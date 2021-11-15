# Home Assistant Add-on: acme.sh

This a home assistant integration of the acme.sh project. It allows to generate a TLS certificate using the ACME protocol.

## Configuration
Tested with the *dns_cf* configuration but It should work, the dnsEnvVariables can be configured with any environment required for acme.sh to work.

```json
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

## About

[acme.sh][acme.sh] an ACME protocol client written purely in Shell (Unix shell) language.
[acme.sh]: https://github.com/acmesh-official/acme.sh
