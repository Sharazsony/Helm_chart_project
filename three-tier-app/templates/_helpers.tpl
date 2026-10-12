{{- define "three-tier-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "three-tier-app.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "three-tier-app.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" }}
app.kubernetes.io/name: {{ include "three-tier-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.global.labels }}
{{ toYaml . }}
{{- end }}
{{- end -}}

{{- define "three-tier-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "three-tier-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "three-tier-app.frontend.fullname" -}}
{{- printf "%s-frontend" (include "three-tier-app.fullname" .) -}}
{{- end -}}

{{- define "three-tier-app.backend.fullname" -}}
{{- printf "%s-backend" (include "three-tier-app.fullname" .) -}}
{{- end -}}

{{- define "three-tier-app.postgres.fullname" -}}
{{- printf "%s-postgres" (include "three-tier-app.fullname" .) -}}
{{- end -}}

{{- define "three-tier-app.frontend.htmlConfigMapName" -}}
{{- printf "%s-frontend-html" (include "three-tier-app.fullname" .) -}}
{{- end -}}

{{- define "three-tier-app.postgres.secretName" -}}
{{- if .Values.postgres.existingSecret -}}
{{- .Values.postgres.existingSecret -}}
{{- else -}}
{{- printf "%s-postgres-secret" (include "three-tier-app.fullname" .) -}}
{{- end -}}
{{- end -}}
