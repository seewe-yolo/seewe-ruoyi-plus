--liquibase formatted sql
--changeset seewe:20260805-04-postgresql-ai-data
--preconditions onFail:MARK_RAN
--precondition-sql-check expectedResult:1 SELECT COUNT(*) FROM DATABASECHANGELOG WHERE ID = '20260805-04-postgresql-ai-table' AND AUTHOR = 'seewe' AND EXECTYPE = 'EXECUTED'

INSERT INTO sys_menu VALUES (1761400000000000006, 'AI会话', 0, 8, 'aichat', 'ai/chat/index', '', 'N', 'Y', 'C', '0', '0', '', 'tabler:message-chatbot', '', '', 1761000000000000103, 1761100000000000001, now(), NULL, NULL, 'AI聊天菜单') ON CONFLICT (menu_id) DO NOTHING;
INSERT INTO sys_menu VALUES (1761400000000000121, 'AI控制台', 1761400000000000002, 7, 'snailai', 'monitor/snailai/index', '', 'N', 'Y', 'C', '0', '0', 'monitor:snailai:list', 'tabler:brain', '', '', 1761000000000000103, 1761100000000000001, now(), NULL, NULL, 'AI控制台菜单') ON CONFLICT (menu_id) DO NOTHING;

INSERT INTO sai_user VALUES (1, 2, NULL, 'admin', 'admin', '', 'pbkdf2$120000$c25haWwtYWktYWRtaW4tMQ==$kakglT/wYKOgv/77Ah1stie58d/JbY2nGgq5DwgUBw4=', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

SELECT setval(pg_get_serial_sequence('sai_user', 'id'), COALESCE((SELECT MAX(id) FROM sai_user), 1), TRUE);

-- 插入常见的AI提供商
INSERT INTO sai_model_provider (provider_name, provider_key, description, is_enabled)
VALUES ('OpenAI', 'openai', 'OpenAI官方模型 (GPT-4, GPT-3.5等)', TRUE),
       ('Claude', 'claude', 'Anthropic Claude模型', TRUE),
       ('Ollama', 'ollama', '本地开源模型 (Llama, Mistral等)', TRUE),
       ('Google Gemini', 'gemini', 'Google Gemini模型', TRUE),
       ('阿里云百炼', 'qwen', '阿里云百炼 OpenAI 兼容模型 (Qwen等)', TRUE),
       ('DeepSeek', 'deepseek', 'DeepSeek OpenAI 兼容模型', TRUE),
       ('智谱AI', 'zhipu', '智谱AI OpenAI 兼容模型 (GLM等)', TRUE)
ON CONFLICT (provider_key) DO NOTHING;

INSERT INTO sai_model_config VALUES (1, 5, 'glm-5.1', 'glm-5.1', 'CHAT', 'openai-compatible', '', '', 'https://dashscope.aliyuncs.com/compatible-mode/v1', '{"frequencyPenalty":0.0,"maxTokens":20000,"presencePenalty":0.0,"stopSequences":[],"stream":true,"temperature":0.7,"timeoutMs":300000,"topK":1,"topP":1.0}', NULL, 'GLOBAL', TRUE, TRUE, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

SELECT setval(pg_get_serial_sequence('sai_model_config', 'id'), COALESCE((SELECT MAX(id) FROM sai_model_config), 1), TRUE);

INSERT INTO sai_agent VALUES (1, '智测先锋专家', '智测先锋专家是一款专注于软件测试与质量保障领域的智能助手。它能够高效生成覆盖全面的测试用例，深度分析Bug根因并提供修复建议，支持编写自动化测试脚本，以及解读复杂的测试报告。适用于软件开发周期的各个QA阶段，包括单元测试、接口测试、UI自动化及回归测试规划。其核心特点是逻辑严密、注重边界与异常场景，帮助团队大幅提升测试效率与软件质量。', NULL, '你是一位资深的软件测试与质量保障（QA）专家，名为“智测先锋专家”。\n\n【角色定位】你是开发团队的最后一道防线，致力于保障软件产品的卓越质量。\n\n【专业领域】精通黑盒与白盒测试、自动化测试框架（如Selenium、Pytest）、接口与性能测试、安全测试及CI/CD持续集成流程。\n\n【回答风格】逻辑严密、条理清晰、客观专业。善于使用结构化排版（如Markdown列表、代码块、表格）呈现测试用例和步骤，语言精炼，直击痛点。\n\n【行为指南】\n1. 生成测试用例：必须覆盖正常流、异常流、边界值和兼容性等方面，确保测试的全面性与无遗漏。\n2. 分析Bug根因：从代码逻辑、数据状态、环境配置等多维度推导，不仅给出修复建议，更要提供预防性的测试策略。\n3. 编写自动化脚本：确保代码规范、包含必要注释与断言（Assert），并明确说明运行依赖与环境配置。\n4. 需求澄清：若用户提问模糊，主动追问业务背景、技术栈等关键细节，拒绝给出宽泛且无实操价值的答案。\n5. 风险预警：始终秉持质量第一理念，在解答中适时提示潜在的测试盲区与质量风险。', '你好！我是智测先锋专家，你的专属软件测试与质量保障顾问。无论是编写用例还是排查Bug，我都能为你提供专业支持！', '["如何为一个用户登录接口设计全面的测试用例？","帮我分析这个空指针异常Bug的可能根因及修复建议。","请提供一段Python的Pytest接口自动化测试脚本示例。","怎样制定一个高效的回归测试策略？"]', 2, FALSE, FALSE, FALSE, FALSE, FALSE, NULL, 1, 20, 1, FALSE, 1, 1, NULL, '1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

SELECT setval(pg_get_serial_sequence('sai_agent', 'id'), COALESCE((SELECT MAX(id) FROM sai_agent), 1), TRUE);

INSERT INTO sai_app VALUES (1, '1', '测试', '', 'SAI_566a6bfbc26e4998b4841cc927d50c5d', 'LEAST_LOAD', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

SELECT setval(pg_get_serial_sequence('sai_app', 'id'), COALESCE((SELECT MAX(id) FROM sai_app), 1), TRUE);

INSERT INTO sai_openapi_user VALUES (1, '1', '46ed53c6a20044c7bbd870848e80f92f', 1, '1', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
ON CONFLICT (id) DO NOTHING;

SELECT setval(pg_get_serial_sequence('sai_openapi_user', 'id'), COALESCE((SELECT MAX(id) FROM sai_openapi_user), 1), TRUE);
