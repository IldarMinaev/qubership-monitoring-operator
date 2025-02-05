{{/* vim: set filetype=mustache: */}}

{{/*
Find a stackdriver-exporter image in various places.
Image can be found from:
* .Values.stackdriverExporter.image from values file
* or default value
*/}}
{{- define "stackdriver-exporter.image" -}}
  {{- if .Values.image -}}
    {{- printf "%s" .Values.image -}}
  {{- else -}}
    {{- print "prometheuscommunity/stackdriver-exporter:v0.12.0" -}}
  {{- end -}}
{{- end -}}

{{/*
Return securityContext for stackdriver-exporter.
*/}}
{{- define "stackdriver-exporter.securityContext" -}}
  {{- if .Values.securityContext -}}
    {{- toYaml .Values.securityContext | nindent 8 }}
  {{- else if not (.Capabilities.APIVersions.Has "security.openshift.io/v1/SecurityContextConstraints") -}}
        runAsUser: 2000
        fsGroup: 2000
  {{- else -}}
        {}
  {{- end -}}
{{- end -}}
