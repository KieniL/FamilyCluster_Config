# vault

I used the documentation from https://github.com/KieniL/vault


I created a secret for auth, a secret for ansparen, a secret for certification (3)
I created a policy for each of the secret with read access (3)
I created a kubernets auth role for each policy in all three namespaces (family,unittest, integrationtest) and all three serviceaccountnames (ReleaseName-service-sa ...) 

I created a admin secret for installer
I created a serviceaccount for installer
I created a policy to have read access on each of the three secrets,
I created a kubernets auth role name installer for the namespaces and servicaccountnames
