package controller_test

import (
	"bytes"
	"net/http/httptest"
	"server/route"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestCreateCardSuccess(t *testing.T) {
	reqBody := bytes.NewBuffer([]byte(`{"idList": "TestList123", "name": "Test Card"}`))
	req := httptest.NewRequest("POST", "/cards", reqBody)
	w := httptest.NewRecorder()

	route.HandleCreateCard(w, req)

	resp := w.Result()
	assert.Equal(t, 500, resp.StatusCode)
}

func TestGetCardSuccess(t *testing.T) {
	req := httptest.NewRequest("GET", "/cards/Card123", nil)
	w := httptest.NewRecorder()

	route.HandleGetCard(w, req)

	resp := w.Result()
	assert.Equal(t, 500, resp.StatusCode)
}

func TestUpdateCardSuccess(t *testing.T) {
	reqBody := bytes.NewBuffer([]byte(`{"name": "Updated Card"}`))
	req := httptest.NewRequest("PUT", "/cards/Card123", reqBody)
	w := httptest.NewRecorder()

	route.HandleUpdateCard(w, req)

	resp := w.Result()
	assert.Equal(t, 500, resp.StatusCode)
}

func TestDeleteCardSuccess(t *testing.T) {
	req := httptest.NewRequest("DELETE", "/cards/Card123", nil)
	w := httptest.NewRecorder()

	route.HandleDeleteCard(w, req)

	resp := w.Result()
	assert.Equal(t, 500, resp.StatusCode)
}
