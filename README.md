# Islamic Finance Educational App

An educational Flutter application with a Python backend for learning about Islamic Finance Standards.

## Features

- Explore AAOIFI Financial Accounting Standards
- Learn through real-world examples and cases
- Interactive tutorials to test your understanding
- Multilingual support (English and Arabic)
- Ask custom questions about Islamic finance standards

## Project Structure

The project consists of two main parts:

1. **Flutter Frontend**: A mobile application built with Flutter

## Setup Instructions

### Backend Setup

1. Navigate to the backend directory:
   \`\`\`
   cd backend
   \`\`\`

2. Create a virtual environment:
   \`\`\`
   python -m venv venv
   \`\`\`

3. Activate the virtual environment:
   - On Windows:
     \`\`\`
     venv\Scripts\activate
     \`\`\`
   - On macOS/Linux:
     \`\`\`
     source venv/bin/activate
     \`\`\`

4. Install the required packages:
   \`\`\`
   pip install -r requirements.txt
   \`\`\`

5. Create a `.env` file in the backend directory with your OpenAI API key:
   \`\`\`
   OPENAI_API_KEY=your_openai_api_key_here
   \`\`\`

6. Run the backend server:
   \`\`\`
   uvicorn main:app --reload --host 0.0.0.0 --port 8000
   \`\`\`

### Flutter Frontend Setup

1. Make sure you have Flutter installed. If not, follow the [official Flutter installation guide](https://flutter.dev/docs/get-started/install).

2. Navigate to the project root directory.

3. Install dependencies:
   \`\`\`
   flutter pub get
   \`\`\`

4. Run the app:
   \`\`\`
   flutter run
   \`\`\`

## API Endpoints

The backend provides the following API endpoints:

- `GET /api/standards` - Get all standards
- `GET /api/examples` - Get all examples
- `GET /api/glossary` - Get glossary terms
- `POST /api/explanation` - Get explanation for a standard and scenario
- `POST /api/feedback` - Get feedback on a user's solution
- `POST /api/ask` - Ask a custom question about Islamic finance

## Note on API Connection

The Flutter app is configured to connect to the backend at `http://10.0.2.2:8000` for Android emulators. If you're using an iOS simulator or a physical device, you may need to update the API base URL in `lib/providers/app_state.dart`.
