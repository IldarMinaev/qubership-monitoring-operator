{{/* vim: set filetype=mustache: */}}

{{/*
Find a cloud-events-exporter image in various places.
Image can be found from:
* .Values.cloudEventsExporter.image from values file
* or default value
*/}}
{{- define "cloudEventsExporter.image" -}}
  {{- if .Values.image -}}
    {{- printf "%s" .Values.image -}}
  {{- else -}}
    {{- print "product/prod.platform.logging_cloud-events-reader:latest" -}}
  {{- end -}}
{{- end -}}

{{/*
Return securityContext for cloud-events-exporter.
*/}}
{{- define "cloudEventsExporter.securityContext" -}}
  {{- if .Values.securityContext -}}
    {{- toYaml .Values.securityContext | nindent 8 }}
  {{- else if not (.Capabilities.APIVersions.Has "security.openshift.io/v1/SecurityContextConstraints") -}}
        runAsUser: 65534
        fsGroup: 65534
  {{- else -}}
        {}
  {{- end -}}
{{- end -}}

{{/*
Namespace need truncate to 26 symbols to allow specify suffixes till 35 symbols
*/}}
{{- define "monitoring.namespace" -}}
  {{- printf "%s" .Release.Namespace | trunc 26 | trimSuffix "-" -}}
{{- end -}}

{{/*
Fullname suffixed with
Adding 9 to 26 truncation
*/}}
{{- define "cloudEventsExporter.fullname" -}}
  {{- printf "%s-%s" (include "monitoring.namespace" .) .Values.name -}}
{{- end -}}

{{- define "cloudEventsExporter.instance" -}}
  {{- printf "%s-%s" (include "monitoring.namespace" .) .Values.name | nospace | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{- define "cloudEventsExporter.version" -}}
  {{- splitList ":" (include "cloudEventsExporter.image" .) | last }}
{{- end -}}
