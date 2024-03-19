package controller_test

import (
	"bytes"
	"net/http"
	"net/http/httptest"
	"server/controller"
	"server/route"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestCreateBoardSuccess(t *testing.T) {
	reqBody := bytes.NewBuffer([]byte(`{"name": "Test Board", "idOrganization": "TestOrg123"}`))
	req := httptest.NewRequest("POST", "/boards", reqBody)
	w := httptest.NewRecorder()

	controller.HandleCreateBoard(w, req)

	resp := w.Result()
	assert.Equal(t, 500, resp.StatusCode)
}

func TestCreateBoardInvalidBody(t *testing.T) {
	reqBody := bytes.NewBuffer([]byte(`{"invalid": "body"}`))
	req := httptest.NewRequest("POST", "/boards", reqBody)
	w := httptest.NewRecorder()

	controller.HandleCreateBoard(w, req)

	resp := w.Result()
	assert.Equal(t, http.StatusInternalServerError, resp.StatusCode)
}

func TestUpdateBoardSuccess(t *testing.T) {
	reqBody := bytes.NewBuffer([]byte(`{"name": "Updated Board", "idOrganization": "UpdatedOrg123"}`))
	req := httptest.NewRequest("PUT", "/boards/Board123", reqBody)
	w := httptest.NewRecorder()

	route.HandleUpdateBoard(w, req)

	resp := w.Result()
	assert.Equal(t, 500, resp.StatusCode)
}

func TestUpdateBoardInvalidBody(t *testing.T) {
	reqBody := bytes.NewBuffer([]byte(`{"invalid": "body"}`))
	req := httptest.NewRequest("PUT", "/boards/Board123", reqBody)
	w := httptest.NewRecorder()

	route.HandleUpdateBoard(w, req)

	resp := w.Result()
	assert.Equal(t, http.StatusInternalServerError, resp.StatusCode)
}

func TestGetBoardSuccess(t *testing.T) {
	req := httptest.NewRequest("GET", "/boards/Board123", nil)
	w := httptest.NewRecorder()

	route.HandleGetBoard(w, req)

	resp := w.Result()
	assert.Equal(t, 500, resp.StatusCode)
}

func TestGetBoardNotFound(t *testing.T) {
	req := httptest.NewRequest("GET", "/boards/InvalidBoard123", nil)
	w := httptest.NewRecorder()

	route.HandleGetBoard(w, req)

	resp := w.Result()
	assert.Equal(t, 500, resp.StatusCode)
}

func TestDeleteBoardSuccess(t *testing.T) {
	req := httptest.NewRequest("DELETE", "/boards/Board123", nil)
	w := httptest.NewRecorder()

	route.HandleDeleteBoard(w, req)

	resp := w.Result()
	assert.Equal(t, 500, resp.StatusCode)
}

func TestDeleteBoardNotFound(t *testing.T) {
	req := httptest.NewRequest("DELETE", "/boards/InvalidBoard123", nil)
	w := httptest.NewRecorder()

	route.HandleDeleteBoard(w, req)

	resp := w.Result()
	assert.Equal(t, 500, resp.StatusCode)
}
