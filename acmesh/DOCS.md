# Acme.sh Add-on

## Installation
Follow these steps to get the add-on installed on your system:

1. Navigate in your Home Assistant frontend to **Supervisor** -> **Add-on Store** -> **Repositories**.
2. Add the repository: **https://github.com/Angoll/acme.sh-homeassistant-addon**
3. Seach acme.sh add-on
3. Click on the "INSTALL" button.

## Configuration

Add-on configuration:

```yaml
accountemail: mail@example.com
domain: home.example.com
dns: dns_cf
dnsEnvVariables:
  - name: CF_Token
    value: xxxx
  - name: CF_Account_ID
    value: xxxx
  - name: CF_Zone_ID
    value: xxxx
keylength: ec-256
fullchainfile: fullchain.pem
keyfile: privkey.pem
```
