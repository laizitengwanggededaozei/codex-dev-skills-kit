# Codex CLI `/` 命令中文指南

> 适合刚从其他工具转到 Codex CLI 的用户。内容按 OpenAI 官方 Codex CLI 文档整理，并结合本机 `codex --help` 核对。

## 1. `/` 命令是什么

在 Codex CLI 的交互界面里，输入 `/` 会打开命令菜单。  
这些命令不会作为普通聊天内容发给模型，而是直接控制当前 Codex 会话，例如切换模型、修改权限、查看改动、压缩上下文、继续旧会话等。

基本用法：

```text
/
/status
/diff
/model
/permissions
```

如果任务正在运行，部分 `/` 命令可以先输入并按 `Tab` 排队，等当前回合结束后再执行。

## 2. 新手最常用命令

### `/status` 查看当前状态

用途：确认当前模型、权限、沙箱、工作目录、可写目录、上下文/token 使用情况。

例子：

```text
/status
```

什么时候用：

- 不确定 Codex 正在用什么模型时。
- 不确定它能不能改文件、能不能运行命令时。
- 发现 Codex 读不到某个目录时。
- 长对话后想看上下文还剩多少时。

### `/diff` 查看 Codex 改了什么

用途：显示当前 Git 工作区差异，包括未暂存、已暂存、未跟踪文件。

例子：

```text
/diff
```

什么时候用：

- Codex 修改代码后，先看改动再决定是否测试或提交。
- 你怀疑 Codex 动了不该动的文件。
- 做 code review 前想快速扫一眼改动范围。

建议习惯：

```text
让 Codex 改代码
→ /diff
→ 让 Codex 跑测试
→ 再 /diff
```

### `/permissions` 调整权限

用途：修改 Codex 做事前是否需要问你。

例子：

```text
/permissions
```

常见选择可以理解为：

- `Read Only`：只读，不让它随便改文件。适合让它分析、审查、解释代码。
- `Auto` / 自动类模式：允许它更主动地编辑或执行，适合你信任当前任务范围时。
- 更开放的模式：减少确认，但风险更高，适合临时环境或你已经清楚后果时。

新手建议：

- 刚开始用 Codex，先用偏保守的权限。
- 让它分析问题时用只读。
- 明确要它修 bug、改代码时，再放开写权限。

当前工作区建议：

- 如果你信任当前任务范围，推荐使用 `Auto` / 自动类模式，并保持工作区写权限。这样 Codex 可以直接修改当前工作区下的项目文件，减少重复确认。
- 仍建议保留确认的操作：删除文件、强制回滚、访问工作区外目录、修改数据库、执行测试服务器脚本、下载依赖或启动会影响环境的长时间服务。
- 如果频繁出现沙箱相关报错，例如 `bwrap: loopback: Failed RTM_NEWADDR`，可以在确认命令风险后批准对应命令前缀，后续同类只读或常规工作区命令会少问很多。

### `/model` 切换模型

用途：切换当前会话使用的模型和可能的推理强度。

例子：

```text
/model
```

什么时候用：

- 简单问题想快一点。
- 复杂重构、跨模块排查、疑难 bug 想用更强推理。
- 当前模型回答质量不够，想换一个。

建议：

- 小修小补：用较快模型。
- 大范围代码理解、架构决策、复杂 bug：用更强模型。
- 切换后可以用 `/status` 确认。

### `/plan` 进入计划模式

用途：让 Codex 先给计划，不直接动手改代码。

例子：

```text
/plan
/plan 帮我规划一下如何把这个 Vue2 页面拆成几个组件，先不要改代码
```

什么时候用：

- 你还不确定改法是否合适。
- 任务比较大，需要先拆步骤。
- 你希望先审查方案，再让 Codex 执行。

注意：官方文档说明，任务已经运行时 `/plan` 暂时不可用。

### `/review` 审查当前工作区

用途：让 Codex 对当前 Git 工作区做一次代码审查，重点找 bug、行为回归、测试缺口。

例子：

```text
/review
```

什么时候用：

- Codex 改完代码后，让另一个审查视角检查。
- 你自己改完一批代码，想在提交前查风险。
- 大改动后担心遗漏边界条件。

常用组合：

```text
/diff
/review
```

### `/compact` 压缩上下文

用途：长对话后，把前面的内容总结压缩，释放上下文空间。

例子：

```text
/compact
```

什么时候用：

- 对话很长，Codex 开始忘记重点。
- 修改了很多轮，快接近上下文上限。
- 准备进入下一阶段，但希望保留关键信息。

注意：压缩不是清空，它会用摘要替代早期对话。

### `/clear` 清空界面并开始新聊天

用途：清空当前终端显示，并开始一个新的对话。

例子：

```text
/clear
```

注意：

- `/clear` 会开启新对话。
- `Ctrl+L` 只是清屏，不会清掉当前聊天上下文。

### `/new` 在同一个 CLI 里开新会话

用途：不退出 Codex，在当前 CLI 里开始一个新对话。

例子：

```text
/new
```

和 `/clear` 的区别：

- `/clear` 会清掉当前终端显示。
- `/new` 开新对话，但不强调清屏。

### `/resume` 恢复旧会话

用途：从保存的会话列表里恢复之前的 Codex 对话。

例子：

```text
/resume
```

什么时候用：

- 昨天的问题今天继续。
- Codex 退出后想接着原来的上下文。
- 某个任务做了一半，需要找回历史。

命令行也可以用：

```bash
codex resume
codex resume --last
```

### `/fork` 分叉当前会话

用途：复制当前对话到一个新线程，方便尝试另一种方案，不破坏原来的上下文。

例子：

```text
/fork
```

适合场景：

- 当前方案 A 还在，但你想试试方案 B。
- 想让 Codex 从同样上下文出发做另一种实现。
- 不想污染原对话历史。

命令行也可以用：

```bash
codex fork
codex fork --last
```

### `/side` 开一个临时旁路对话

用途：从当前对话里临时开一个小分支，问一个聚焦问题，不打断主线。

例子：

```text
/side 这个修复方案有没有明显风险？
/side 帮我只检查 SQL 兼容性，不要改代码
```

适合场景：

- 主任务还在推进，但你想临时问一个问题。
- 想快速验证一个想法。
- 不希望这个问题污染主对话。

注意：官方文档说明，`/side` 在另一个 side conversation 内和 review mode 中不可用。

## 3. 文件、项目和上下文相关命令

### `/mention` 指定文件或目录

用途：把某个文件加入当前对话，让 Codex 明确参考它。

例子：

```text
/mention src/api/user.ts
/mention pages/report/inbound/index.vue
```

什么时候用：

- 你知道问题大概率在哪个文件。
- Codex 没主动看到某个关键文件。
- 让它解释、修改、对比指定文件。

实用提问：

```text
/mention src/api/user.ts
解释这个文件的请求封装逻辑
```

```text
/mention pages/report/inbound/index.vue
帮我检查分页参数有没有和后端接口对齐
```

### `/init` 生成 `AGENTS.md`

用途：在当前目录生成 `AGENTS.md` 脚手架，用来保存项目级长期指令。

例子：

```text
/init
```

`AGENTS.md` 可以写什么：

- 项目如何启动。
- 测试命令。
- 代码风格。
- 不要改哪些文件。
- 后端/前端目录约定。
- 提交前检查步骤。

例子：

```markdown
# AGENTS.md

- 前端项目使用 npm run lint 检查。
- 后端项目修改后优先运行 mvn -DskipTests compile。
- 不要随意格式化整个文件，只改和任务相关的代码。
- 修改接口字段前先检查对应 DTO、VO 和前端调用。
```

### `/compact` 管理长上下文

虽然前面已经提过，但它对项目开发很重要。  
如果你连续修了多个问题，建议每完成一个阶段后用一次：

```text
/compact
```

然后继续说：

```text
基于刚才压缩后的上下文，继续修复下一个接口字段问题。
```

## 4. 工具、插件、MCP 相关命令

### `/mcp` 查看 MCP 工具

用途：列出当前配置的 Model Context Protocol 工具。

例子：

```text
/mcp
/mcp verbose
```

什么时候用：

- 你想确认 Codex 是否能访问某些外部工具。
- 刚添加 MCP server 后想检查是否生效。
- 工具调用异常时排查配置。

命令行管理 MCP：

```bash
codex mcp list
codex mcp get openaiDeveloperDocs
codex mcp add openaiDeveloperDocs --url https://developers.openai.com/mcp
codex mcp remove openaiDeveloperDocs
```

### `/apps` 浏览应用连接器

用途：浏览可用或已连接的 app connector，并插入到提示词中。

例子：

```text
/apps
```

适合场景：

- 需要 Codex 使用某个外部 app 的上下文。
- 想看当前有哪些 connector 可用。

### `/plugins` 管理插件

用途：浏览已安装或可发现的插件，查看插件工具，安装建议插件或管理可用性。

例子：

```text
/plugins
```

适合场景：

- 你安装了 Codex plugin，想确认是否可用。
- 想知道当前会话能调用哪些插件能力。

### `/experimental` 开关实验功能

用途：打开实验功能设置界面。

例子：

```text
/experimental
```

注意：

- 有些功能开启后需要重启 Codex。
- 实验功能可能变化较快，不建议在重要生产任务里盲目依赖。

## 5. 运行过程控制命令

### `/ps` 查看后台终端

用途：查看实验性后台终端和最近输出。

例子：

```text
/ps
```

什么时候用：

- Codex 启动了长时间运行的命令。
- 你想看 dev server、测试、构建是否还在跑。
- 任务看起来卡住了，想检查后台命令输出。

### `/stop` 停止后台终端

用途：停止当前会话里的后台终端任务。

例子：

```text
/stop
```

别名：

```text
/clean
```

什么时候用：

- dev server 不需要了。
- 测试命令卡住。
- Codex 启动了你不想继续跑的后台任务。

### `/copy` 复制最新回复

用途：把 Codex 最近一次完成的输出复制到剪贴板。

例子：

```text
/copy
```

快捷键：

```text
Ctrl+O
```

注意：如果当前回合还在运行，它复制的是最近一次已经完成的输出。

## 6. 界面和体验设置命令

### `/fast` 快速模式

用途：对支持的模型开启、关闭或查看 Fast mode。

例子：

```text
/fast on
/fast off
/fast status
```

适合场景：

- 简单问题希望响应更快。
- 复杂问题觉得质量不够时可以关闭。

### `/personality` 调整回复风格

用途：修改 Codex 的沟通风格，不需要重写提示词。

例子：

```text
/personality
```

官方文档列出的风格包括：

- `friendly`
- `pragmatic`
- `none`

如果当前模型不支持 personality-specific instructions，这个命令可能不会显示。

### `/statusline` 配置底部状态栏

用途：选择 TUI 底部显示哪些信息。

例子：

```text
/statusline
```

可配置项包括：

- 模型
- 模型 + 推理强度
- 上下文统计
- rate limit
- Git 分支
- token 计数
- session id
- 当前目录/项目根目录
- Codex 版本

### `/title` 配置终端标题

用途：选择终端窗口或 tab 标题显示哪些信息。

例子：

```text
/title
```

可配置项包括：

- app 名称
- 项目名
- 状态
- thread
- Git 分支
- 模型
- 任务进度

### `/keymap` 修改快捷键

用途：查看、修改并保存 Codex TUI 快捷键。

例子：

```text
/keymap
```

绑定名示例：

```text
ctrl-a
shift-enter
page-down
```

## 7. 调试和退出命令

### `/debug-config` 查看配置层级

用途：排查为什么当前配置和你想的不一样。

例子：

```text
/debug-config
```

它会显示配置层级、策略来源和一些限制项，例如：

- `allowed_approval_policies`
- `allowed_sandbox_modes`
- `mcp_servers`
- `rules`
- `experimental_network`

什么时候用：

- `config.toml` 改了但没生效。
- 权限模式被限制。
- MCP 配置看起来异常。
- 企业/团队环境里有上层策略。

### `/logout` 退出登录

用途：清除本机 Codex 登录凭据。

例子：

```text
/logout
```

适合场景：

- 共享机器。
- 切换账号。
- 登录状态异常，需要重新登录。

### `/quit` 或 `/exit` 退出 CLI

用途：离开当前 Codex CLI。

例子：

```text
/quit
/exit
```

注意：退出前先确认重要改动已经保存、测试或提交。

## 8. 官方内置命令速查表

| 命令 | 作用 | 常见使用场景 |
|---|---|---|
| `/permissions` | 设置 Codex 不询问你时可以做什么 | 临时放开/收紧权限 |
| `/sandbox-add-read-dir` | Windows 下给沙箱增加只读目录 | Windows 原生 CLI 读不到外部目录 |
| `/agent` | 切换当前 agent thread | 查看或继续子代理线程 |
| `/apps` | 浏览 app connectors | 插入外部 app 到提示词 |
| `/plugins` | 浏览和管理插件 | 查看插件工具、安装/启用插件 |
| `/clear` | 清屏并开始新聊天 | 想清掉当前上下文重新问 |
| `/compact` | 压缩对话释放上下文 | 长任务、长对话后 |
| `/copy` | 复制最近完成的 Codex 输出 | 复制总结、计划、报告 |
| `/diff` | 查看 Git diff | 审查 Codex 改动 |
| `/exit` | 退出 CLI | 结束会话 |
| `/experimental` | 开关实验功能 | 启用实验能力 |
| `/feedback` | 发送日志给维护者 | 报告问题、提交诊断 |
| `/init` | 生成 `AGENTS.md` | 建立项目长期规则 |
| `/logout` | 退出登录 | 换账号、共享机器 |
| `/mcp` | 列出 MCP 工具 | 检查外部工具是否可用 |
| `/mention` | 附加文件到对话 | 指定 Codex 关注某文件 |
| `/model` | 切换模型/推理强度 | 简单任务提速，复杂任务加深推理 |
| `/fast` | 开关 Fast mode | 简单任务提高速度 |
| `/plan` | 进入计划模式 | 先出方案，不直接改代码 |
| `/goal` | 设置实验性长期目标 | 长任务追踪目标，需要开启 features.goals |
| `/personality` | 设置沟通风格 | 调整回复简洁/协作风格 |
| `/ps` | 查看后台终端 | 检查长命令、dev server、测试 |
| `/stop` | 停止后台终端 | 停止卡住或不需要的命令 |
| `/fork` | 分叉当前对话 | 尝试另一种方案 |
| `/side` | 临时旁路对话 | 问一个不打断主线的小问题 |
| `/resume` | 恢复历史会话 | 接着之前的任务 |
| `/new` | 同一 CLI 中开新对话 | 换任务但不退出 |
| `/quit` | 退出 CLI | 结束会话 |
| `/review` | 审查当前工作树 | 提交前找 bug 和测试缺口 |
| `/status` | 显示会话配置和 token | 确认模型、权限、上下文 |
| `/debug-config` | 打印配置诊断 | 排查配置为什么不生效 |
| `/statusline` | 配置底部状态栏 | 自定义 TUI footer |
| `/title` | 配置终端标题 | 自定义 terminal title |
| `/keymap` | 修改快捷键 | 自定义 TUI 快捷键 |

## 9. 和 `/` 命令配合使用的 shell 命令

这些不是 `/` 命令，而是在普通终端里运行的 `codex` 命令。

### 启动 Codex

```bash
codex
```

指定目录启动：

```bash
codex -C /path/to/project
```

带第一句话启动：

```bash
codex "帮我检查这个项目的启动方式"
```

### 继续或分叉会话

```bash
codex resume
codex resume --last
codex fork
codex fork --last
```

### 非交互模式 `codex exec`

适合脚本、CI、一次性任务。

```bash
codex exec "summarize the repository structure and list risky areas"
```

允许写工作区：

```bash
codex exec --sandbox workspace-write "修复 lint 问题并说明改动"
```

只输出最终结果到文件：

```bash
codex exec "生成最近 10 个提交的 release notes" > release-notes.md
```

### 常用全局参数

```bash
codex -m gpt-5.4
codex -C /path/to/project
codex --add-dir /path/to/another/dir
codex -a on-request
codex --sandbox workspace-write
codex --search
codex --no-alt-screen
```

含义简表：

| 参数 | 作用 |
|---|---|
| `-C, --cd <DIR>` | 指定 Codex 工作目录 |
| `--add-dir <DIR>` | 增加额外可写目录 |
| `-m, --model <MODEL>` | 指定模型 |
| `-a, --ask-for-approval <POLICY>` | 设置审批策略 |
| `-s, --sandbox <MODE>` | 设置沙箱模式 |
| `--search` | 开启网页搜索 |
| `--no-alt-screen` | 禁用 alternate screen，保留终端滚动历史 |
| `-i, --image <FILE>` | 初始提示附带图片 |

## 10. 新手工作流示例

### 场景 A：让 Codex 先理解项目

```text
/status
请先阅读项目结构，告诉我后端、前端、启动方式和主要模块，不要修改文件。
```

### 场景 B：让 Codex 修一个 bug

```text
/permissions
/mention src/xxx/problem-file.ts
这个页面分页参数传错了，请定位并修复，改完后说明影响范围。
/diff
```

### 场景 C：复杂任务先要计划

```text
/plan 把这个报表页面从旧接口迁移到新接口，请先列计划，不要改代码
```

确认计划后再说：

```text
按这个计划执行，改动保持最小，完成后运行相关检查。
```

### 场景 D：改完后自查

```text
/diff
/review
```

### 场景 E：长任务中途压缩上下文

```text
/compact
继续刚才的迁移任务，下一步处理前端字段映射。
```

### 场景 F：临时问一个旁路问题

```text
/side 只从数据库兼容性角度看，刚才的 SQL 有没有风险？
```

### 场景 G：保存项目规则

```text
/init
```

然后把常用规则写进 `AGENTS.md`，以后 Codex 进入该目录会自动参考。

## 11. 使用建议

1. 先用 `/status` 确认环境，再开始重要任务。
2. 改代码后一定用 `/diff` 看变更。
3. 大任务先用 `/plan`，不要一上来让 Codex 直接改。
4. 会话太长用 `/compact`，不要等上下文快满才处理。
5. 不确定 Codex 能不能动文件时，用 `/permissions`。
6. 指定文件优先用 `/mention`，比单纯在文字里写路径更明确。
7. 提交前用 `/review`，让 Codex 用审查视角再看一遍。
8. 项目长期规范写进 `AGENTS.md`，不要每次重复口头说明。

## 12. 参考来源

- OpenAI 官方 Codex CLI 概览：https://developers.openai.com/codex/cli
- OpenAI 官方 Codex CLI slash commands：https://developers.openai.com/codex/cli/slash-commands
- OpenAI 官方 Codex CLI command line options：https://developers.openai.com/codex/cli/reference
- OpenAI 官方 Codex non-interactive mode：https://developers.openai.com/codex/noninteractive
- OpenAI Codex GitHub 仓库：https://github.com/openai/codex
