package controller

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
)

type CardResponse struct {
	ID   string `json:"id"`
	Name string `json:"name"`
}

func CreateCard(idList, name, apiKey, apiToken string) (*CardResponse, error) {
	fmt.Println("Creating card")
	url := fmt.Sprintf("https://api.trello.com/1/cards?idList=%s&name=%s&key=%s&token=%s", idList, name, apiKey, apiToken)

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

	var cardResponse CardResponse
	err = json.Unmarshal(body, &cardResponse)
	if err != nil {
		return nil, err
	}

	return &cardResponse, nil
}

func GetCard(id, apiKey, apiToken string) (*CardResponse, error) {
	fmt.Println("Getting card")
	url := fmt.Sprintf("https://api.trello.com/1/cards/%s?key=%s&token=%s", id, apiKey, apiToken)

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

	var cardResponse CardResponse
	err = json.Unmarshal(body, &cardResponse)
	if err != nil {
		return nil, err
	}

	return &cardResponse, nil
}

func UpdateCard(id, newName, apiKey, apiToken string) (*CardResponse, error) {
	fmt.Println("Updating card")
	url := fmt.Sprintf("https://api.trello.com/1/cards/%s?name=%s&key=%s&token=%s", id, newName, apiKey, apiToken)

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

	var cardResponse CardResponse
	err = json.Unmarshal(body, &cardResponse)
	if err != nil {
		return nil, err
	}

	return &cardResponse, nil
}

func DeleteCard(id, apiKey, apiToken string) error {
	fmt.Println("Deleting card")
	url := fmt.Sprintf("https://api.trello.com/1/cards/%s?key=%s&token=%s", id, apiKey, apiToken)

	req, err := http.NewRequest("DELETE", url, nil)
	if err != nil {
		return err
	}

	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("unexpected status code: %d", resp.StatusCode)
	}

	return nil
}
