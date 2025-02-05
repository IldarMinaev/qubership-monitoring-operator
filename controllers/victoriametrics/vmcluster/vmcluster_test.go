package vmcluster

import (
	"testing"

	v1alpha1 "github.com/Netcracker/qubership-monitoring-operator/api/v1alpha1"
	"github.com/stretchr/testify/assert"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

var (
	cr *v1alpha1.PlatformMonitoring
)

func TestVmClusterManifests(t *testing.T) {
	cr = &v1alpha1.PlatformMonitoring{
		ObjectMeta: metav1.ObjectMeta{
			Namespace: "monitoring",
		},
		Spec: v1alpha1.PlatformMonitoringSpec{
			Victoriametrics: &v1alpha1.Victoriametrics{
				VmCluster: v1alpha1.VmCluster{},
			},
		},
	}
	t.Run("Test vmCluster manifest with nil labels and annotation", func(t *testing.T) {
		m, err := vmCluster(cr)
		if err != nil {
			t.Fatal(err)
		}
		assert.NotNil(t, m, "vmCluster manifest should not be empty")
		assert.NotNil(t, m.GetLabels())
		assert.Nil(t, m.GetAnnotations())
	})
	cr = &v1alpha1.PlatformMonitoring{
		ObjectMeta: metav1.ObjectMeta{
			Namespace: "monitoring",
		},
	}

}
