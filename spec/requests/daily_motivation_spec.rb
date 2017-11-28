require 'rails_helper'

RSpec.describe 'Motivation API', type: :request do
   # initialize test data 
  let!(:daily_motivations) { create_list(:daily_motivation, 10) }
  let(:daily_motivation_id) { daily_motivations.first.id }

  # Test suite for GET /daily_motivations
  describe 'GET /daily_motivations' do
    # make HTTP get request before each example
    before { get '/daily_motivations' }

    it 'returns daily_motivations' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /daily_motivations/:id
  describe 'GET /daily_motivations/:id' do
    before { get "/daily_motivations/#{daily_motivation_id}" }

    context 'when the record exists' do
      it 'returns the daily_motivation' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(daily_motivation_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:daily_motivation_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find DailyMotivation/)
      end
    end
  end

    # Test suite for POST /daily_motivations
    describe 'POST /daily_motivations' do
      # valid payload
      let(:valid_attributes) { { quote: 'Learn Elm', author: 'Donatello' } }

      context 'when the request is valid' do
        before { post '/daily_motivations', params: valid_attributes }

        it 'creates a daily_motivation' do
          expect(json['quote']).to eq('Learn Elm')
        end

        it 'returns status code 201' do
          expect(response).to have_http_status(201)
        end
      end

      context 'when the request is invalid' do
        before { post '/daily_motivations', params: { quote: 'Foobar' } }

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns a validation failure message' do
          expect(response.body)
            .to match(/Validation failed: Author can't be blank/)
        end
      end
    end

    # Test suite for PUT /daily_motivations/:id
    describe 'PUT /todos/:id' do
      let(:valid_attributes) { { quote: 'Shopping' } }

      context 'when the record exists' do
        before { put "/daily_motivations/#{daily_motivation_id}", params: valid_attributes }

        it 'updates the record' do
          expect(response.body).to be_empty
        end

        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
      end
    end

    # Test suite for DELETE /daily_motivations/:id
    describe 'DELETE /daily_motivations/:id' do
      before { delete "/daily_motivations/#{daily_motivation_id}" }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

