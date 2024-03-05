package controller

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
)

type ListResponse struct {
	ID   string `json:"id"`
	Name string `json:"name"`
}

func CreateList(idBoard, name, apiKey, apiToken string) (*ListResponse, error) {
	url := fmt.Sprintf("https://api.trello.com/1/lists?name=%s&idBoard=%s&key=%s&token=%s", name, idBoard, apiKey, apiToken)

	req, err := http.NewRequest("POST", url, nil)
	if err != nil {
		return nil, err
	}

	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("unexpected status code: %d", resp.StatusCode)
	}

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}

	var listResponse ListResponse
	err = json.Unmarshal(body, &listResponse)
	if err != nil {
		return nil, err
	}

	return &listResponse, nil
}

type List struct {
	ID   string `json:"id"`
	Name string `json:"name"`
}

func GetLists(idBoard, apiKey, apiToken string) ([]*List, error) {
	url := fmt.Sprintf("https://api.trello.com/1/boards/%s/lists?key=%s&token=%s", idBoard, apiKey, apiToken)

	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		return nil, err
	}

	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("unexpected status code: %d", resp.StatusCode)
	}

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}

	var lists []*List
	err = json.Unmarshal(body, &lists)
	if err != nil {
		return nil, err
	}

	return lists, nil
}

func UpdateList(idList, newName, apiKey, apiToken string) (*ListResponse, error) {
	url := fmt.Sprintf("https://api.trello.com/1/lists/%s?name=%s&key=%s&token=%s", idList, newName, apiKey, apiToken)

	req, err := http.NewRequest("PUT", url, nil)
	if err != nil {
		return nil, err
	}

	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("unexpected status code: %d", resp.StatusCode)
	}

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}

	var listResponse ListResponse
	err = json.Unmarshal(body, &listResponse)
	if err != nil {
		return nil, err
	}

	return &listResponse, nil
}
