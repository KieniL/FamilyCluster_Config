
# secretconfig

Every secret is only local so you see a static view here.


## Application Properties secrets

Since the environment variables can be seen in /proc/1/environ the properties file is mounted as a a volume from the secret. The volume can also be seen with df. At further looking into it, it is easier to iterate the /proc processes since there are few processes due to containerization (only three) in comparison to 11 tmpfs (2 to /app).


### Ansparen
```yaml
{{ if .Values.ansparen.deploy }}
apiVersion: v1
kind: Secret
metadata:
  name: "{{ .Release.Name }}-ansparen-application-properties-secret"
  namespace: {{ .Release.Namespace }}
  labels:
    app.kubernetes.io/name: "{{ .Release.Name }}-ansparen-application-properties-secret"
    app.kubernetes.io/instance: "{{ .Release.Name }}-ansparen-application-properties-secret"
    app.kubernetes.io/version: "1.0"
    app.kubernetes.io/component: secret
    app.kubernetes.io/part-of: familyapp
    app.kubernetes.io/managed-by: helm
type: Opaque
stringData:
  application.properties: |
    server.port = 8080
    spring.application.name = ansparen
    management.health.probes.enabled=true
    ## Spring DATASOURCE (DataSourceAutoConfiguration & DataSourceProperties)
    spring.datasource.url=jdbc:mysql://{{ .Release.Name }}-mysql:3306/DB
    spring.datasource.username=USER
    spring.datasource.password=PW
    # The SQL dialect makes Hibernate generate better SQL for the chosen database
    spring.jpa.properties.hibernate.dialect = org.hibernate.dialect.MySQL8Dialect
    # Hibernate ddl auto (create, create-drop, validate, update)
    spring.jpa.hibernate.ddl-auto = update
    logging.level.com.kienast.ansparservice = INFO
    authURL = {{ .Release.Name }}-authservice:8080
{{ end }}
```

### Api

```yaml
{{ if .Values.api.deploy }}
apiVersion: v1
kind: Secret
metadata:
  name: "{{ .Release.Name }}-api-application-properties-secret"
  namespace: {{ .Release.Namespace }}
  labels:
    app.kubernetes.io/name: "{{ .Release.Name }}-api-application-properties-secret"
    app.kubernetes.io/instance: "{{ .Release.Name }}-api-application-properties-secret"
    app.kubernetes.io/version: "1.0"
    app.kubernetes.io/component: secret
    app.kubernetes.io/part-of: familyapp
    app.kubernetes.io/managed-by: helm
type: Opaque
stringData:
  application.properties: |
    server.port=8080
    server.servlet.context-path=/api
    spring.application.name=apiservice
    authURL={{ .Release.Name }}-authservice:8080
    ansparURL={{ .Release.Name }}-ansparservice:8080
    certURL={{ .Release.Name }}-certservice:8080
    management.health.probes.enabled=true
    logging.level.com.kienast.apiservice= INFO
{{ end }}
```

### Auth

```yaml
{{ if .Values.auth.deploy }}
apiVersion: v1
kind: Secret
metadata:
  name: "{{ .Release.Name }}-auth-application-properties-secret"
  namespace: {{ .Release.Namespace }}
  labels:
    app.kubernetes.io/name: "{{ .Release.Name }}-auth-application-properties-secret"
    app.kubernetes.io/instance: "{{ .Release.Name }}-auth-application-properties-secret"
    app.kubernetes.io/version: "1.0"
    app.kubernetes.io/component: secret
    app.kubernetes.io/part-of: familyapp
    app.kubernetes.io/managed-by: helm
type: Opaque
stringData:
  application.properties: |
    server.port=8080
    spring.application.name=familyauth
    management.health.probes.enabled=true
    ## Spring DATASOURCE (DataSourceAutoConfiguration & DataSourceProperties)
    spring.datasource.url=jdbc:mysql://{{ .Release.Name }}-mysql:3306/DB
    spring.datasource.username=USER
    spring.datasource.password=PASS
    # The SQL dialect makes Hibernate generate better SQL for the chosen database
    spring.jpa.properties.hibernate.dialect = org.hibernate.dialect.MySQL8Dialect
    # Hibernate ddl auto (create, create-drop, validate, update)
    spring.jpa.hibernate.ddl-auto = update
    companyName=kieni
    logging.level.com.kienast.authservice=INFO
{{ end }}
```
### Cert

```yaml
{{ if .Values.cert.deploy }}
apiVersion: v1
kind: Secret
metadata:
  name: "{{ .Release.Name }}-cert-application-properties-secret"
  namespace: {{ .Release.Namespace }}
  labels:
    app.kubernetes.io/name: "{{ .Release.Name }}-cert-application-properties-secret"
    app.kubernetes.io/instance: "{{ .Release.Name }}-cert-application-properties-secret"
    app.kubernetes.io/version: "1.0"
    app.kubernetes.io/component: secret
    app.kubernetes.io/part-of: familyapp
    app.kubernetes.io/managed-by: helm
type: Opaque
stringData:
  application.properties: |
    server.port = 8080
    spring.application.name = cert
    management.health.probes.enabled=true
    management.health.livenessState.enabled=true
    management.health.readinessState.enabled=true
    ## Spring DATASOURCE (DataSourceAutoConfiguration & DataSourceProperties)
    spring.datasource.url=jdbc:mysql://{{ .Release.Name }}-mysql:3306/DB
    spring.datasource.username=USER
    spring.datasource.password=PASS
    # The SQL dialect makes Hibernate generate better SQL for the chosen database
    spring.jpa.properties.hibernate.dialect = org.hibernate.dialect.MySQL8Dialect
    # Hibernate ddl auto (create, create-drop, validate, update)
    spring.jpa.hibernate.ddl-auto = update
    logging.level.com.kienast.certservice = INFO
    authURL = {{ .Release.Name }}-authservice:8080
{{ end }}
```
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
