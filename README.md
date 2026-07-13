# Custom Shibboleth IdP Version 5 Installer for Users of Pakistan

### Identity and Access Management (IAM)
Identity and Access Management (IAM) is a framework for managing digital identities and controlling access to resources. It ensures that only authorized users have the right access to the right resources at the right time. IAM encompasses policies, technologies, and tools that manage users’ identities, authenticate their access, and authorize their actions within systems, networks, or applications. This framework improves security, operational efficiency, and regulatory compliance by streamlining how access is granted and monitored.

### Shibboleth Identity Provider (IdP)
Shibboleth Identity Provider (IdP) is a prominent IAM tool used for federated identity management. Federated IAM allows users to authenticate with one identity across multiple applications or systems, which is essential in organizations where single sign-on (SSO) is necessary. Shibboleth IdP specifically uses SAML (Security Assertion Markup Language) to authenticate and share identity attributes between organizations securely. Within IAM, Shibboleth IdP serves as a bridge between users and resources across different domains, enabling efficient and secure access management.

---

## Overview
This installer automates the install of version 5 of the [Shibboleth IdP](https://shibboleth.atlassian.net/wiki/spaces/IDP5/overview) on a dedicated server, using the same Ansible automation originally built by the Australian Access Federation (AAF) and adapted here for HEC Pakistan IAM deployments. It supports one of the following operating systems:
* Rocky Linux 8 or 9
* CentOS Stream 8 or 9
* RHEL 8 or 9
* Oracle Linux 8 or 9
* Ubuntu 20.04 (Focal Fossa) or 22.04 (Jammy Jellyfish)

The manual preparation steps below (Python, timezone, Ansible) are shown for **both** Debian/Ubuntu (`apt`) and RHEL-family (`dnf`/`yum`) systems — pick the block matching your OS. Once `bootstrap-v5.sh` is running, it detects the OS itself and installs everything else (Jetty, MariaDB, Java 17, etc.) using the correct package manager automatically; the manual steps here only cover what must exist *before* the installer can run at all.

For background on the upstream AAF installer this is based on, see the [AAF IdPv4 Installer Knowledge base](https://support.aaf.edu.au/support/solutions/articles/19000159910-shibboleth-idp-version-5-installer) — note that AAF-specific details there (federation manager URLs, FTicks contacts) do not apply to an HEC Pakistan deployment; use this repo's own configuration instead (see [Preparing the bootstrap-v5.ini File](#preparing-the-bootstrap-v5ini-file) below).

# Shibboleth IdP Version 5 Installer

## Test / Staging Environment Checklist

This guide is for standing up a **test IdP** ahead of a production rollout. A test IdP still handles real signing keys and may federate with real SPs during integration testing, so treat it carefully:

- [ ] Use a dedicated test VM/host — do not run this on a shared or production box
- [ ] Give the test host its own hostname/domain, distinct from production (e.g. `idp-test.your-institution.edu.pk`, never the production `idp.your-institution.edu.pk`)
- [ ] In `bootstrap-v5.ini`, set `ENVIRONMENT=test` (the template in this repo now defaults to `test` — confirm it wasn't changed)
- [ ] Confirm `FM_TEST_REG` in `bootstrap-v5.sh` points at your federation's **test** registry, not production
- [ ] Use a test/self-signed metadata signing setup where possible; never reuse production signing keys on a test instance
- [ ] Set `ACME_EMAIL` to a team mailbox you can actually monitor, not a personal address
- [ ] Confirm with your federation operator (e.g. the HEC Pakistan Jagger registry) before enabling `ENABLE_EDUGAIN=true` on a test instance — most federations don't want test IdPs technically joining eduGAIN
- [ ] Periodically re-run bootstrap or rebuild the VM so the test environment doesn't quietly drift from what production will look like

### Actions undertaken during installation
The installation process will:

Optionally perform a yum -y update (system wide package upgrade). Please note that the installer uses yum or apt-get for the installation of all system components (except Jetty and Shibboleth IdP).

* Install all required dependencies (git, ansible, mariadb etc). With the previous step in mind, bootstrap will always use the latest versions of these packages.
* Create self signed keys for Jetty. These are for initial testing of the IdP and are replaced when further customising the Shibboleth IdP
* Install Jetty with Shibboleth IdP. Jetty runs on port 443 and optionally ports 80 and 8443 and creates the Shibboleth IdP web app context /idp.
* Install a MariaDB instance. A database is created (name: idp_db, user: idp_admin) with these schemas populated.
* Installs chrony for time synchronisation.
* Opens local firewall ports 443 and optionally ports 80 and 8443
* Optionally configures the IdP for integration with eduGAIN
* Optionally configures the IdP to enable various REFEDS specifications.

Here’s a complete guide to resolving the Python interpreter issue with Ansible by creating a new `ansible.cfg` file:

---

### Open terminal as a root (Linux Server). 

Run the following command:

```bash
sudo -s
```

Enter the root password.

---

### Grab the latest packages
Update and upgrade the database of available packages.

**Debian/Ubuntu:**
```bash
apt update && apt upgrade -y
```

**RHEL / Rocky / Stream / Oracle Linux:**
```bash
dnf update -y
```

---

### Ensure `Python` is Installed
First, confirm that Python 3 is installed. If it's not, install it with the following commands:

**Debian/Ubuntu:**
```bash
apt install -y python3 python3-pip python3-apt
```

**RHEL / Rocky / Stream / Oracle Linux:**
```bash
dnf install -y python3 python3-pip
```

---

### Change TimeZone w.r.t to your country:
```bash
timedatectl set-timezone Asia/Karachi 
```

---

### Set the IdP hostname

The public domain name of the IdP is used to determine the entity ID of the IdP.

(ATTENTION: Replace `idp.example.org` with your IdP's Full Qualified `Domain Name` and `<HOSTNAME>` with the IdP's short hostname. For a **test** instance, use a distinct test hostname/domain — never point this at your production entity ID.)

Add an entry to `/etc/hosts`:

```bash
echo "<YOUR-SERVER-IP-ADDRESS> idp.example.org <HOSTNAME>" >> /etc/hosts
```

Set the system hostname:

```bash
hostnamectl set-hostname <HOSTNAME>
```

---

### Installing `Ansible`

Prefer installing Ansible through **one** method only — mixing an `apt`/`dnf`-installed Ansible with a `pip --user` install on the same root account can leave two different versions on `$PATH` (the pip one typically lands in `/root/.local/bin`), which makes it unclear which one actually runs. Pick a method below:

**Option A — OS package manager (simplest, may lag behind the latest Ansible release):**

Debian/Ubuntu:
```bash
apt update
apt install -y ansible
```

RHEL / Rocky / Stream / Oracle Linux:
```bash
dnf install -y epel-release
dnf install -y ansible
```

**Option B — pip (gets a current Ansible release; useful if your OS repo's version is too old for the collections this installer depends on):**

```bash
apt install -y python3-pip   # or: dnf install -y python3-pip
python3 -m pip install --user ansible
```

If you installed via pip as root, make sure `/root/.local/bin` is on `$PATH` (add `export PATH="$HOME/.local/bin:$PATH"` to `~/.bashrc`), and verify only one `ansible` resolves:

```bash
which -a ansible
ansible --version
```

### Ansible Python Interpreter

If Ansible reports it can't find the right Python interpreter, set it explicitly:

* Run the following command to set the environment variable:

   ```bash
   export ANSIBLE_PYTHON_INTERPRETER=/usr/bin/python3
   ```
* You can add this line to your (root) `.bashrc` or `.bash_profile` to ensure it persists for future sessions, since the installer must be run as root:

   ```bash
   echo 'export ANSIBLE_PYTHON_INTERPRETER=/usr/bin/python3' >> ~/.bashrc
   source ~/.bashrc
   ```

### Upgrading Ansible

If you installed via pip, upgrade in place with:

```bash
python3 -m pip install --upgrade --user ansible
```

If you installed via `apt`/`dnf`, use that package manager's upgrade command instead — running both will reintroduce the dual-install issue noted above.

---

### How this repo fits together

`bootstrap-v5.sh` clones the actual Ansible playbook (`site_v5.yml`, `tasks/`, `templates/`, `host_vars/` templates) fresh from the `GIT_REPO` URL hardcoded near the top of the script — currently `pakistan-identity-federation/shibboleth-idp5-installer` — into `/opt/shibboleth-idp5-installer/repository` on the target machine. That clone, not the copy you're reading `bootstrap-v5.sh`/`bootstrap-v5.ini` from, is what actually runs. This means:

- Fixes to `bootstrap-v5.sh` / `bootstrap-v5.ini` (e.g. the Federation Manager URLs, ACME email) only take effect for real installs once they're committed and pushed to whichever repo the `curl` command below points at.
- Fixes to the playbook itself (`tasks/`, `site_v5.yml`, `host_vars/*.dist.*` templates) only take effect once they're merged into the `pakistan-identity-federation` org repo, since that's what `GIT_REPO` clones regardless of where you downloaded the bootstrap scripts from.

Keep both in sync when making changes here.

### Preparing the `bootstrap-v5.ini` File

1. **Download `bootstrap-v5.ini`:**

   For new installations, download the `bootstrap-v5.ini` file with the following command:

   ```bash
   curl https://raw.githubusercontent.com/talha50819/shibboleth-idp5-installer/main/bootstrap-v5.ini > bootstrap-v5.ini
   ```

2. **Edit `bootstrap-v5.ini`:**

   Open and configure the file using a text editor, for example:

   ```bash
   vi bootstrap-v5.ini
   ```

3. **Configure Required Sections:**

Press `i` to enter Insert Mode. Now you can type and edit the file.

   - **[main]**: Review, configure, and uncomment each field in this section. In particular:
     - `HOST_NAME` / `ENTITY_ID` — this test instance's own hostname, not production's
     - `ENVIRONMENT` — must be `test` for a test build (the template in this repo defaults to `test`; double-check it wasn't left as `production`)
   - **[ldap]**: If using LDAP, configure the settings here. TLS configuration can be updated post-bootstrap if needed.
   - **[logging, policy, and advanced]**: Carefully review and adjust settings as required, understanding the impact of each change. In particular:
     - `FTICKS_KEY_ID` / `FTICKS_SECRET_KEY` — request these from your own federation operator, not AAF
     - `DOMAIN_NAME` — this host's own FQDN
     - `ACME_EMAIL` — a monitored team mailbox, not a personal address

Click the `Esc` key and then type `:wq!` to save and exit the configuration.

4. **Verify the Federation Manager URLs:**

   Before running the installer, confirm `FM_TEST_REG` and `FM_PROD_REG` near the top of `bootstrap-v5.sh` point at your own federation's registry (e.g. the HEC Pakistan Jagger instance), not AAF's. These are only shown to you as an informational link at the end of installation, but pointing at the wrong federation's registration page will send you to register with the wrong organisation.

## Running the Installer

1. **Download and Prepare `bootstrap-v5.sh`:**

   Execute the following command to download and make the installer executable:

   ```bash
   curl https://raw.githubusercontent.com/talha50819/shibboleth-idp5-installer/main/bootstrap-v5.sh > bootstrap-v5.sh && chmod u+x bootstrap-v5.sh
   ```

   Ensure `bootstrap-v5.ini` is in the same directory as `bootstrap-v5.sh`.

2. **Run the Installer as Root:**

   Execute the installer script as the root user:

   ```bash
   ./bootstrap-v5.sh
   ```

This process will install and configure the server to operate as a Shibboleth Identity Provider (IdP).

---

## Event Logging

The installer provides detailed information on each step undertaken during the setup process. If the installation completes successfully, this output can be disregarded. However, for future reference, all installer output is logged to:

```
cat /opt/shibboleth-idp5-installer/activity.log
```

---

## Allowing the installer to run again
In general you will never need to re-run the bootstrap-v5.sh script after it has completed creating the `/opt/shibboleth-idp5-installer` directory. You should use the deploy or upgrade scripts instead.

If you must re-run bootstrap-v5.sh then you remove the lock file first. Note this will overwrite any previous installations.

```bash
rm /root/.lock-idp-bootstrap-v5 && ./bootstrap-v5.sh
```

The bootstrap-v5 process will now start over and attempt to install and configure your server to operate as a Shibboleth IdP.