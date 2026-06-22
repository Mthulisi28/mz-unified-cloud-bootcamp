import urllib.request
import json

# Your repository configuration
USER = "Mthulisi28"
REPO = "mz-unified-cloud-bootcamp"

def scan_github_folder(folder_path=""):
    """Recursively fetches file maps using the public GitHub API"""
    api_url = f"https://api.github.com/repos/{USER}/{REPO}/contents/{folder_path}"
    
    # Request headers to comply with GitHub's standard API guidelines
    req = urllib.request.Request(api_url, headers={'User-Agent': 'Mozilla/5.0'})
    
    try:
        with urllib.request.urlopen(req) as response:
            items = json.loads(response.read().decode())
            
            for item in items:
                if item['type'] == 'dir':
                    # Drill down into subdirectories
                    scan_github_folder(item['path'])
                else:
                    filename = item['name'].lower()
                    # Check if the file matches standard database or RDS related keywords
                    if any(kw in filename for kw in ['db', 'database', 'rds', 'aurora', 'sql', 'exercise']):
                        print(f"📁 Match Found in Folder: [{item['path'].split('/')[0]}]")
                        print(f"   📄 File Name: {item['name']}")
                        print(f"   🔗 Browser URL: https://github.com/{USER}/{REPO}/blob/main/{urllib.parse.quote(item['path'])}\n")
                        
    except Exception as e:
        # Gracefully handle empty directories or root-level skips
        pass

if __name__ == "__main__":
    print(f"🔎 Scanning https://github.com/{USER}/{REPO} for Cloud Databases/RDS materials...\n")
    scan_github_folder()
    print("🏁 Scan complete.")