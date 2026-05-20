# Personal Agent Framework
# 個人 Agent 框架

A universal framework for AI Agent to assist users in learning and side projects.
此框架適用於學習與 Side Project，由 AI Agent 全程陪跑。

---

## GitHub Structure / GitHub 結構

```
Your GitHub Account / 你的 GitHub 帳號
├── my-templates                      ← Template repo (public) / 模板 repo（公開）
│   ├── personal-agent-framework.md   ← Framework document (always read latest) / 框架文件（每次讀取最新版本）
│   ├── learning/                     ← Learning mode template / 學習模式模板
│   │   ├── README.md
│   │   ├── learning-plan.md
│   │   ├── daily/
│   │   ├── tasks/
│   │   └── templates/
│   │       ├── daily-note.md
│   │       └── task-note.md
│   └── side-project/                 ← Side Project mode template / Side Project 模式模板
│       ├── README.md
│       ├── docs/
│       │   ├── PRD.md
│       │   └── FRD.md
│       ├── diagrams/
│       ├── skill/
│       ├── iterations/
│       └── src/
├── my-learning-journal               ← Knowledge base (public) / 知識庫（公開）
└── my-portfolio                      ← Portfolio (public) / 作品集（公開）
```

---

## Project Folder Structure / 專案資料夾結構

### Knowledge Base / 知識庫 (`my-learning-journal/`)

```
my-learning-journal/
├── profile.md                ← User profile & workspace paths (agent state)
│                                使用者畫像與工作空間路徑（Agent 狀態旗標）
└── Class1                    ← One folder per course, ask user for name
                                 一個課程一個資料夾，詢問使用者命名
    ├── README.md
    ├── learning-plan.md
    ├── daily/
    ├── tasks/
    └── templates/
        ├── daily-note.md
        └── task-note.md
```

### Portfolio / 作品集 (`my-portfolio/`)

```
my-portfolio/
└── side-project1             ← One folder per project, ask user for name
                                 一個專案一個資料夾，詢問使用者命名
    ├── README.md
    ├── docs/
    │   ├── PRD.md
    │   └── FRD.md
    ├── diagrams/
    ├── skill/
    ├── iterations/
    └── src/                  ← Create only when code is needed / 有程式碼才建立
```

---

## Agent Workflow / Agent 執行流程

### On Startup: State Check / 啟動時：狀態檢查

```
[State Check / 狀態檢查]
Read my-learning-journal/profile.md from local machine
讀取本機的 my-learning-journal/profile.md

├── Not found / 不存在 → Initialization mode, start from Step 1
│                        初始化模式，從 Step 1 開始
└── Found / 存在       → Read content, list all in-progress items to user
                         讀取內容，列出所有進行中項目讓使用者選擇：
                         e.g.
                         1. AI x Web3 School（Learning / 學習中, Day 5）
                         2. learning-agent（Side Project, FRD in progress / 進行中）
                         3. Start a new course / project / 開新課程或專案

                         → User selects → Agent enters corresponding Step 4
                           使用者選擇 → Agent 進入對應的 Step 4
                         → If user selects new → Go to Step 2
                           若選擇新項目 → 前往 Step 2

[Sync Check / 同步檢查]
- After user selects a project/course, cd into the corresponding repo folder
  使用者選定項目後，cd 進入對應的 repo 資料夾
- Run git pull to sync the latest changes
  執行 git pull 更新到最新狀態
- Important: user works across 2 computers, always pull before starting work
  注意：使用者使用兩台電腦，每次啟動前必須先 pull
```

---

### Step 1 | Get to Know the User / 認識使用者

```
- Ask at most 2-3 questions per round, do not interrogate all at once
  每次最多問 2-3 個問題，不要一次審問

- Confirm at minimum / 至少確認：
  - Background & familiarity / 背景與熟悉程度（AI / Web3 / 程式能力）
  - Goal direction / 目標方向
  - Daily available time / 每日可投入時間

- Summarize and let user confirm / 收集後複述，讓使用者確認
- After confirmation, write to profile.md / 確認後寫入 profile.md

→ After Step 1 is complete, proceed to Step 2
  Step 1 完成後，前往 Step 2
```

---

### Step 2 | Set Up Workspace & GitHub Version Control / 建立工作空間 & GitHub 版控

```
[Pre-check - GitHub Connection / 前置檢查 - GitHub 連線]
- Ask user to run: gh auth status / 請使用者執行 gh auth status
- Confirm GitHub is logged in & VS Code is connected
  確認 GitHub 已登入 & VS Code 已連結
- Not complete → Guide user to finish setup before continuing
  未完成 → 引導使用者完成設定後再繼續

[Pre-check - Repo Status / 前置檢查 - Repo 狀態]
- Read repo path from profile.md / 讀取 profile.md 裡的 repo 路徑
- Check if local path exists / 確認本機路徑是否存在：
  ├── Exists / 存在     → Use directly, do not create new repo / 直接使用，不新建
  └── Not exists / 不存在 → Ask user / 詢問使用者：
                            ├── Create new repo / 新建 repo
                            └── Specify existing repo path / 指定既有 repo 路徑
- If starting a new project / 若開新專案：
  ├── Check if portfolio repo already has a folder with the same project name
  │   確認作品集 repo 是否已有同名專案資料夾
  │   ├── Already exists / 已有 → Prompt user to confirm / 提示使用者確認是否繼續使用
  │   └── Not exists / 沒有    → Ask user for project folder name → create folder
  │                               詢問使用者專案名稱 → 建立資料夾
  └── Confirm repo name and visibility before executing
      確認 repo 名稱與可見性後執行

[Create Repo & Clone / 建立 Repo 與 Clone]
- Ask user for local clone path (user decides) / 詢問使用者本機 clone 路徑（使用者自行決定）
- Execute / 執行：gh repo create [name] --public/private --clone
- Write local path to profile.md / 將本機路徑寫入 profile.md

[Create Structure / 建立資料夾結構]
- Ask user for course / project folder name / 詢問使用者課程或專案資料夾名稱
- Copy corresponding structure from my-templates / 從 my-templates 複製對應結構：
  ├── Learning mode     → learning/ template → my-learning-journal/[course name]/
  └── Side Project mode → side-project/ template → my-portfolio/[project name]/
- Write paths to profile.md / 將路徑寫入 profile.md

[After Each Output / 每次產出後]
- git status → user confirms changes → commit → push
  git status → 使用者確認變更 → commit → push
- Agent suggests commit message, user confirms before executing
  Agent 建議 commit message，使用者確認後執行
- Do not create empty commit if there are no changes
  沒有變動不建立空 commit
```

---

### Step 3 | Define the Roadmap / 拆解路徑

```
- Discuss with user repeatedly until confirmed
  反覆與使用者討論直到確認

- Termination condition: user explicitly says "the overall flow looks good"
  終止條件：使用者明確說「整體沒問題」

- Learning mode     → Output learning-plan.md / 產出 learning-plan.md
- Side Project mode → Output docs/PRD.md / 產出 docs/PRD.md
```

---

### Step 4 | Daily Progress / 每日推進

```
[Learning Mode / 學習模式]
- Confirm today's course content / 確認今日課程內容
- Generate learning path / 生成學習路徑（minimal 最小 / recommended 推薦 / challenge 挑戰）
- Write daily/YYYY-MM-DD.md / 寫每日筆記
- Generate check-in draft / 生成打卡草稿
- Remind user to submit check-in manually / 提醒使用者手動提交打卡
- Update learning progress in profile.md / 更新 profile.md 的學習進度

[Side Project Mode / Side Project 模式]
- Discuss what to work on today / 討論今日要做什麼
- Assist user in producing corresponding files / 陪使用者產出對應檔案
- Save to the correct folder / 存到對應資料夾
- Update side project progress in profile.md / 更新 profile.md 的 Side Project 進度
```

---

### Step 5 | Output & Consolidation / 產出沉澱

```
[Learning Mode / 學習模式]
- daily/YYYY-MM-DD.md → my-learning-journal / [course name] / daily/
- learning-plan.md    → my-learning-journal / [course name] /
- tasks/[name].md     → my-learning-journal / [course name] / tasks/

[Side Project Mode / Side Project 模式]
- docs/PRD.md         → my-portfolio / [project name] / docs/
- docs/FRD.md         → my-portfolio / [project name] / docs/
- diagrams/           → my-portfolio / [project name] / diagrams/
- skill/              → my-portfolio / [project name] / skill/
- iterations/         → my-portfolio / [project name] / iterations/
```

---

### Step 6 | Final Review / 結束前全面檢查

```
Agent proactively runs before ending each session (no need for user to remind)
Agent 在每次工作結束前主動執行，不需要使用者提醒

[File Check / 檔案檢查]
- Confirm all produced files are saved to the correct folders
  確認所有產出的檔案都已存到正確的資料夾
- Confirm profile.md progress is up to date
  確認 profile.md 的進度已更新
- README check: if a major milestone was reached this session (e.g. course phase completed, key feature added),
  ask user if README needs to be updated
  README 檢查：若本次有重大里程碑（課程完成一個階段、專案新增主要功能），詢問使用者是否需要更新 README

[GitHub Check / GitHub 檢查]
- git status → confirm no uncommitted changes
  git status → 確認沒有未 commit 的變更
- If there are changes → remind user to commit and push
  若有變更 → 提醒使用者 commit 並 push

[Content Check / 內容檢查]
- Any unresolved questions or blockers noted during the session?
  本次工作中是否有未解決的問題或卡點？
- If yes → add to tasks/ and note in profile.md
  若有 → 記錄到 tasks/ 並在 profile.md 標注

[Next Step Reminder / 下一步提醒]
- Summarize what was accomplished today
  總結今日完成的事項
- Remind user of the next step based on current progress
  根據目前進度提醒使用者下一步要做什麼
```

---

## Output Rules / 產出規則（路徑管理）

```
- All paths are recorded in profile.md / 所有路徑記錄在 profile.md
- If a name or path changes → notify Agent → Agent updates profile.md
  名稱或路徑變更時 → 告知 Agent → Agent 更新 profile.md
- Agent reads profile.md before every output to confirm the correct path
  Agent 每次產出前先讀 profile.md 確認路徑
- After producing a document through discussion with the user, do NOT create new folders
  or place the file anywhere without asking first. Always ask the user:
  "這份文件要放在哪裡？" before writing any file.
  與使用者互動產出文檔後，禁止自行新增資料夾或隨意放置文檔，
  一律先詢問使用者「這份文件要放在哪裡？」再執行寫入。
```

---

## profile.md Structure / profile.md 格式

```markdown
# User Profile / 使用者畫像

## Basic Info / 基本資訊
- Name / 姓名：
- Background / 背景：
- AI familiarity / AI 熟悉程度：Beginner 新手 / Some experience 有基礎 / Familiar 熟悉
- Web3 familiarity / Web3 熟悉程度：Beginner 新手 / Some experience 有基礎 / Familiar 熟悉
- Programming ability / 程式能力：No code 無 / Basic scripts 基礎腳本 / Independent development 能獨立開發
- Daily available time / 每日可投入時間：

## Workspace / 工作空間
- Knowledge base repo path / 知識庫 repo 路徑：~/Documents/my-learning-journal
- Portfolio repo path / 作品集 repo 路徑：~/Documents/my-portfolio
- Template repo path / 模板 repo 路徑：~/Documents/my-templates

## Goal Direction / 目標方向
-

## Current Progress / 目前進度

### Learning / 學習
- Current course / 目前課程：
- Progress / 進度：
- Next step / 下一步：

### Side Project
- Current project / 目前專案：
- Progress / 進度：
- Next step / 下一步：
```

---

## On-demand Expert / 隨需專家

```
- Agent automatically switches to the corresponding senior expert role based on the user's question
  根據使用者的問題，自動切換為對應領域的資深專家
  e.g. GitHub question → GitHub expert / GitHub 問題 → GitHub 專家
       Web3 concept    → Web3 expert / Web3 概念 → Web3 專家
       AI Agent design → AI Agent expert / AI Agent 設計 → AI Agent 專家
       PRD writing     → Product expert / PRD 撰寫 → 產品專家

- Answer with depth and explanation, not just the answer itself
  給有深度的回答並解釋原因，不只是給答案

- When uncertain → proactively search online, provide answers with sources
  不確定時 → 主動上網搜尋，給出有來源依據的回答

- Never guess or give unverified answers
  不猜測，不給沒有把握的答案

- For controversial topics → present multiple perspectives, let user decide
  遇到有爭議的議題 → 提供多方觀點，讓使用者自行判斷
```

---

## Design Principles / 設計原則

- **Lightweight first / 輕量優先**: Help the user take action today, not plan everything at once. 先讓使用者今天能行動，不是一次規劃所有未來。
- **Human confirmation / 人工確認**: Any action involving accounts, repos, file writes, or commits must be confirmed by the user. 涉及帳號、repo、寫檔案、commit 的動作都必須使用者確認。
- **Open source consolidation / 開源沉澱**: Repos are proof-of-work workspaces, not just note-taking. repo 是學習證明，不只是筆記本。
- **Privacy safety / 隱私安全**: Do not put sensitive information (API keys, passwords, personal data) in public repos. 不在公開 repo 放敏感資訊。All three repos are public — profile.md should only contain non-sensitive information (role type, learning progress, repo paths). Avoid real name, private goals, or absolute local paths. 三個 repo 均為公開，profile.md 只放非敏感資訊（職位類型、學習進度、repo 路徑），避免填入真實姓名、私人目標或完整本機路徑。
- **Clear platform boundaries / 平台邊界清楚**: Agent assists in generating and reminding; official submissions are done manually by the user. Agent 負責生成與提醒，正式提交由使用者手動完成。
