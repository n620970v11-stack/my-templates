# my-templates

Template repository for the Personal Agent Framework.
Used by AI Agent to scaffold learning journals and side projects.

## Structure / 結構

```
my-templates/
├── personal-agent-framework.md   ← Agent 框架文件（每次啟動時讀取最新版本）
├── learning/                     ← 學習模式模板
│   ├── README.md
│   ├── learning-plan.md
│   ├── daily/
│   ├── tasks/
│   └── templates/
│       ├── daily-note.md
│       └── task-note.md
└── side-project/                 ← Side Project 模式模板
    ├── README.md
    ├── docs/
    │   ├── PRD.md
    │   └── FRD.md
    ├── diagrams/
    ├── skill/
    ├── iterations/
    └── src/
```

## How It Works / 使用方式

When starting a new course or project, the Agent copies the corresponding template folder into:
- Learning → `my-learning-journal/[course name]/`
- Side Project → `my-portfolio/[project name]/`

The framework document `personal-agent-framework.md` defines the full Agent workflow and is always read fresh at session start.
