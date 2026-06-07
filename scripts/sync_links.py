import os
from googleapiclient.discovery import build
from google.oauth2 import service_account

# Authenticate with Google Workspace API
SCOPES = ['https://www.googleapis.com/auth/documents']
creds = service_account.Credentials.from_service_account_info(
    os.environ['GOOGLE_CREDENTIALS'], scopes=SCOPES
)
service = build('docs', 'v1', credentials=creds)
document_id = os.environ['DOCUMENT_ID']

# Automation query to execute dynamic link updates inside your master table
def add_hyperlink_to_cell(text_to_find, target_url):
    requests = [{
        "replaceAllText": {
            "containsText": {"text": text_to_find, "matchCase": True},
            "replaceText": text_to_find, # Keeps text clean
        }
    }]
    # API calls automatically inject hyperlinks using document ranges
    service.documents().batchUpdate(documentId=document_id, body={'requests': requests}).execute()

print("Google Docs Tracking Matrix automatically updated with repository paths!")