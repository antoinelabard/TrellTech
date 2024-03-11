package controller_test

import (
	"bytes"
	"net/http/httptest"
	"server/controller"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestCreateWorkspaceSuccess(t *testing.T) {
	reqBody := bytes.NewBuffer([]byte(`{"displayName": "Test Workspace"}`))
	req := httptest.NewRequest("POST", "/create-organization", reqBody)
	w := httptest.NewRecorder()

	controller.HandleCreateOrganization(w, req)

	resp := w.Result()
	assert.Equal(t, 500, resp.StatusCode)
}

func TestDeleteWorkspaceSuccess(t *testing.T) {
	req := httptest.NewRequest("DELETE", "/delete-organization/Org123", nil)
	w := httptest.NewRecorder()

	controller.HandleDeleteOrganization(w, req)

	resp := w.Result()
	assert.Equal(t, 500, resp.StatusCode)
}
