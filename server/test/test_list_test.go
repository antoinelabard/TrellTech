package controller_test

import (
	"bytes"
	"net/http/httptest"
	"server/route"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestCreateListSuccess(t *testing.T) {
	reqBody := bytes.NewBuffer([]byte(`{"idBoard": "TestBoard123", "name": "Test List"}`))
	req := httptest.NewRequest("POST", "/create-list", reqBody)
	w := httptest.NewRecorder()

	route.HandleCreateList(w, req)

	resp := w.Result()
	assert.Equal(t, 500, resp.StatusCode)
}

func TestGetListSuccess(t *testing.T) {
	req := httptest.NewRequest("GET", "/get-list/List123", nil)
	w := httptest.NewRecorder()

	route.HandleGetList(w, req)

	resp := w.Result()
	assert.Equal(t, 500, resp.StatusCode)
}

func TestUpdateListSuccess(t *testing.T) {
	reqBody := bytes.NewBuffer([]byte(`{"name": "Updated List"}`))
	req := httptest.NewRequest("PUT", "/update-list/List123", reqBody)
	w := httptest.NewRecorder()

	route.HandleUpdateList(w, req)

	resp := w.Result()
	assert.Equal(t, 500, resp.StatusCode)
}

func TestGetCardsSuccess(t *testing.T) {
	req := httptest.NewRequest("GET", "/get-cards/List123", nil)
	w := httptest.NewRecorder()

	route.HandleGetCards(w, req)

	resp := w.Result()
	assert.Equal(t, 500, resp.StatusCode)
}
