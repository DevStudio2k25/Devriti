# 🚀 GitHub Push Guide

## ❌ Current Issue

Error: `Permission denied to Himanshuksnh`

This means you need to authenticate with your **DevStudio2k25** GitHub account.

## ✅ Solution: Authenticate with GitHub

### Option 1: Using GitHub CLI (Recommended)

1. **Install GitHub CLI** (if not installed):
   - Download from: https://cli.github.com/
   - Or use: `winget install --id GitHub.cli`

2. **Login to GitHub:**
   ```bash
   gh auth login
   ```
   - Select: GitHub.com
   - Select: HTTPS
   - Authenticate in browser
   - Login with **DevStudio2k25** account

3. **Push the code:**
   ```bash
   git push -u origin main
   ```

### Option 2: Using Personal Access Token

1. **Create Token:**
   - Go to: https://github.com/settings/tokens
   - Click "Generate new token (classic)"
   - Select scopes: `repo` (all)
   - Generate and copy token

2. **Push with token:**
   ```bash
   git push https://YOUR_TOKEN@github.com/DevStudio2k25/Devriti.git main
   ```

### Option 3: Using Git Credential Manager

1. **Clear old credentials:**
   ```bash
   git credential-manager erase https://github.com
   ```

2. **Push (will prompt for login):**
   ```bash
   git push -u origin main
   ```
   - Login with **DevStudio2k25** account when prompted

### Option 4: Manual Upload (Quick & Easy)

If above methods don't work:

1. Go to: https://github.com/DevStudio2k25/Devriti
2. Click "uploading an existing file"
3. Drag and drop the entire project folder
4. Commit changes

## 📋 What's Already Done

✅ Git initialized  
✅ Files added  
✅ Committed with message: "Initial commit: DEVRITI Mental Health App"  
✅ Remote added: https://github.com/DevStudio2k25/Devriti.git  
✅ Branch renamed to `main`  

**Only push remaining!**

## 🎯 Quick Commands

```bash
# Option 1: GitHub CLI
gh auth login
git push -u origin main

# Option 2: With Token
git push https://YOUR_TOKEN@github.com/DevStudio2k25/Devriti.git main

# Option 3: Clear credentials
git credential-manager erase https://github.com
git push -u origin main
```

## ✅ After Successful Push

Your code will be live at:
**https://github.com/DevStudio2k25/Devriti**

## 📝 Repository Info

- **Owner:** DevStudio2k25
- **Repo:** Devriti
- **Email:** devstudio2k25@gmail.com
- **Branch:** main
- **Files:** 203 files, 17,262 lines of code

---

**Choose any option above to push your code! 🚀**
