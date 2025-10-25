{{/*
Expand the name of the chart.
*/}}
{{- define "kubernetes.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kubernetes.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "bookstack.mariadb.fullname" -}}
{{- include "common.names.dependency.fullname" (dict "chartName" "mariadb" "chartValues" .Values.mariadb "context" $) -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kubernetes.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kubernetes.labels" -}}
helm.sh/chart: {{ include "kubernetes.chart" . }}
{{ include "kubernetes.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kubernetes.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kubernetes.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubernetes.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "kubernetes.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the proper BookStack image name
*/}}
{{- define "bookstack.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) -}}
{{- end -}}

{{/*
Return the proper OS Shell image name
*/}}
{{- define "volumePermissions.image" -}}
{{- include "common.images.image" (dict "imageRoot" .Values.volumePermissions.image "global" .Values.global) -}}
{{- end -}}

{{/*
Return the Database hostname
*/}}
{{- define "bookstack.databaseHost" -}}
{{- ternary (include "bookstack.mariadb.fullname" .) (tpl .Values.externalDatabase.host $) .Values.mariadb.enabled -}}
{{- end -}}

{{/*
Return the Database port
*/}}
{{- define "bookstack.databasePort" -}}
{{- ternary 3306 (tpl (.Values.externalDatabase.port | toString) $) .Values.mariadb.enabled -}}
{{- end -}}

{{/*
Return the Database user
*/}}
{{- define "bookstack.databaseUser" -}}
{{- if .Values.mariadb.enabled -}}
    {{- if .Values.global.mariadb -}}
        {{- if .Values.global.mariadb.auth -}}
            {{- coalesce .Values.global.mariadb.auth.username .Values.mariadb.db.user -}}
        {{- else -}}
            {{- .Values.mariadb.db.user -}}
        {{- end -}}
    {{- else -}}
        {{- .Values.mariadb.db.user -}}
    {{- end -}}
{{- else -}}
    {{- tpl .Values.externalDatabase.user $ -}}
{{- end -}}
{{- end -}}

{{/*
Return the Database password
*/}}
{{- define "bookstack.databasePassword" -}}
{{- if .Values.mariadb.enabled -}}
    {{- if .Values.global.mariadb -}}
        {{- if .Values.global.mariadb.auth -}}
            {{- coalesce .Values.global.mariadb.auth.password .Values.mariadb.db.password -}}
        {{- else -}}
            {{- .Values.mariadb.db.password -}}
        {{- end -}}
    {{- else -}}
        {{- .Values.mariadb.db.password -}}
    {{- end -}}
{{- else -}}
    {{- tpl .Values.externalDatabase.password $ -}}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "bookstack.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}