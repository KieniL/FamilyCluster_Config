
# secretconfig

Every secret is only local so you see a static view here.

# tls secret
The secret used by the ingress
apiVersion: v1
kind: Secret
metadata:
  name: {{ .Release.Name }}-tls-secret
  namespace: {{ .Release.Namespace }}
  labels:
    app.kubernetes.io/name: "{{ .Release.Name }}-tls-secret"
    app.kubernetes.io/instance: "{{ .Release.Name }}-tls-secret"
    app.kubernetes.io/version: "1.0"
    app.kubernetes.io/component: tls-secret
    app.kubernetes.io/part-of: familyapp
    app.kubernetes.io/managed-by: helm
type: kubernetes.io/tls
data:
  tls.crt: base64 encoded crt
  tls.key: base64 encoded key

## Installer secret
The secret used by the installer

```yaml
{{ if .Values.installer.deploy }}
apiVersion: v1
kind: Secret
metadata:
  name: "{{ .Release.Name }}-installer-secret"
  namespace: {{ .Release.Namespace }}
  labels:
    app.kubernetes.io/name: "{{ .Release.Name }}-installer-secret"
    app.kubernetes.io/instance: "{{ .Release.Name }}-installer-secret"
    app.kubernetes.io/version: "1.0"
    app.kubernetes.io/component: secret
    app.kubernetes.io/part-of: familyapp
    app.kubernetes.io/managed-by: helm
type: Opaque
stringData:
  DB_HOST: {{ .Release.Name }}-mysql
  DB_PORT: "3306"
  DB_ADMIN_USER: root
  DB_ADMIN_PASSWORD: PW
  AUTH_DB: DB
  AUTH_USER: USER
  AUTH_PASS: PASS
  ANSPAR_DB: DB
  ANSPAR_USER: USER
  ANSPAR_PASS: PASS
  CERT_DB: DB
  CERT_USER: USER
  CERT_PASS: PASS
{{ end }}
```
## mysql secret
The root password for mysql

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: "{{ .Release.Name }}-mysql-secret"
  namespace: {{ .Release.Namespace }}
  labels:
    app.kubernetes.io/name: "{{ .Release.Name }}-mysql-secret"
    app.kubernetes.io/instance: "{{ .Release.Name }}-mysql-secret"
    app.kubernetes.io/version: "1.0"
    app.kubernetes.io/component: secret
    app.kubernetes.io/part-of: familyapp
    app.kubernetes.io/managed-by: helm
type: Opaque
stringData:
    MYSQL_PASSWORD: "PW"
```
