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
	fmt.Println("Creating list")
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

type Lists struct {
	ID   string `json:"id"`
	Name string `json:"name"`
}

func GetListsinaboard(idBoard, apiKey, apiToken string) ([]*List, error) {
	fmt.Println("Getting lists")
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
	fmt.Println("Updating list")
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

type Card struct {
	ID   string `json:"id"`
	Name string `json:"name"`
}

func GetCards(idList, apiKey, apiToken string) ([]*Card, error) {
	url := fmt.Sprintf("https://api.trello.com/1/lists/%s/cards?key=%s&token=%s", idList, apiKey, apiToken)

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

	var cards []*Card
	err = json.Unmarshal(body, &cards)
	if err != nil {
		return nil, err
	}

	return cards, nil
}

type List struct {
	ID   string `json:"id"`
	Name string `json:"name"`
}

func GetList(idList, apiKey, apiToken string) (*List, error) {
	url := fmt.Sprintf("https://api.trello.com/1/lists/%s?key=%s&token=%s", idList, apiKey, apiToken)

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

	var list List
	err = json.Unmarshal(body, &list)
	if err != nil {
		return nil, err
	}

	return &list, nil
}
