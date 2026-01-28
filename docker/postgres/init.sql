-- ========================================
-- 剧本数据库初始化脚本
-- ========================================

-- ========================================
-- 用户表 (UserDAO) - 基础表，其他表依赖
-- ========================================
CREATE TABLE IF NOT EXISTS "user" (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- 插入用户 mock 数据
INSERT INTO "user" (username, email, password_hash, created_at, updated_at) VALUES
('user1', 'user1@example.com', 'hash1', '2024-01-01 00:00:00', '2024-01-01 00:00:00'),
('user2', 'user2@example.com', 'hash2', '2024-01-02 00:00:00', '2024-01-02 00:00:00'),
('user3', 'user3@example.com', 'hash3', '2024-01-03 00:00:00', '2024-01-03 00:00:00'),
('user4', 'user4@example.com', 'hash4', '2024-01-04 00:00:00', '2024-01-04 00:00:00'),
('user5', 'user5@example.com', 'hash5', '2024-01-05 00:00:00', '2024-01-05 00:00:00');

-- ========================================
-- 剧本表 (screenplay)
-- ========================================
CREATE TABLE IF NOT EXISTS screenplay (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    description VARCHAR(1000) NOT NULL DEFAULT '',
    tags VARCHAR(100) NOT NULL DEFAULT '',
    cover_image_key VARCHAR(128) NOT NULL DEFAULT '',
    create_time TIMESTAMP NOT NULL,
    is_completed BOOLEAN NOT NULL,
    version VARCHAR(14) NOT NULL DEFAULT '1.0',
    status VARCHAR(30) NOT NULL DEFAULT '作者努力创作中……',
    additional_information JSONB NOT NULL DEFAULT '{}',
    author_uid BIGINT NOT NULL,
    CONSTRAINT fk_screenplay_author FOREIGN KEY (author_uid) REFERENCES "user"(id)
);

-- 插入剧本 mock 数据
INSERT INTO screenplay (name, description, tags, cover_image_key, create_time, is_completed, version, status, additional_information, author_uid) VALUES
('星空传说', '在一个遥远的星球上，人类与外星生物共同生活的故事', '科幻,冒险', 'cover1.jpg', '2024-01-10 00:00:00', false, '1.0', '作者努力创作中……', '{"character_cards": [], "endings": []}', 1),
('都市传说', '现代都市中的超自然事件调查故事', '悬疑,都市', 'cover2.jpg', '2024-01-11 00:00:00', true, '2.0', '已发布', '{"character_cards": [{"card_id": 1, "character_name": "侦探小李", "description": "敏锐的私家侦探"}], "endings": [{"ending_id": 1, "chapter_name": "终章"}]}', 2),
('古代宫廷', '中国古代宫廷中的权力斗争故事', '历史,宫廷', 'cover3.jpg', '2024-01-12 00:00:00', false, '1.0', '作者努力创作中……', '{"character_cards": [], "endings": []}', 3),
('校园恋爱', '高中校园的青春恋爱故事', '恋爱,青春', 'cover4.jpg', '2024-01-13 00:00:00', false, '1.1', '连载中', '{"character_cards": [{"card_id": 2, "character_name": "男主角", "description": "阳光开朗的学生"}], "endings": []}', 4),
('末世求生', '末日世界中的生存冒险故事', '末世,生存', 'cover5.jpg', '2024-01-14 00:00:00', false, '1.0', '作者努力创作中……', '{"character_cards": [], "endings": []}', 5);

-- ========================================
-- 剧本脚本表 (script)
-- ========================================
CREATE TABLE IF NOT EXISTS script (
    id BIGSERIAL PRIMARY KEY,
    script_code TEXT NOT NULL
);

-- 插入剧本脚本 mock 数据
INSERT INTO script (script_code) VALUES
('function onStart() { print("场景开始"); }'),
('function onChoice() { print("做出选择"); }'),
('function onEnd() { print("场景结束"); }'),
('function onEnter() { playMusic("bgm1.mp3"); }'),
('function onExit() { stopMusic(); }');

-- ========================================
-- 剧本设定表 (play_preset)
-- ========================================
CREATE TABLE IF NOT EXISTS play_preset (
    id BIGSERIAL PRIMARY KEY,
    type VARCHAR(20) NOT NULL,
    alias VARCHAR(30) NOT NULL,
    name VARCHAR(90) NOT NULL,
    path VARCHAR(300) NOT NULL,
    content TEXT NOT NULL
);

-- 插入剧本设定 mock 数据
INSERT INTO play_preset (type, alias, name, path, content) VALUES
('worldview', 'space', '星空世界观', '/presets/space/worldview.txt', '在一个遥远的未来，人类已经征服了星辰大海，建立了庞大的星际联邦。'),
('character_card', 'hero', '英雄角色卡', '/presets/characters/hero.txt', '英雄角色设定：勇敢、正义、富有同情心。'),
('character_background', 'merchant', '商人背景', '/presets/backgrounds/merchant.txt', '商人背景：来自贸易星系的精明商人，擅长谈判。'),
('history', 'war', '星际战争史', '/presets/history/war.txt', '2150年爆发的星际战争改变了整个宇宙的格局。'),
('worldview', 'city', '都市世界观', '/presets/city/worldview.txt', '现代都市中隐藏着许多不为人知的秘密和超自然力量。');

-- ========================================
-- 游戏资源表 (game_resoure) - 注意拼写为 resoure
-- ========================================
CREATE TABLE IF NOT EXISTS game_resoure (
    id BIGSERIAL PRIMARY KEY,
    screenplay_id BIGINT NOT NULL,
    name VARCHAR(50) NOT NULL,
    path VARCHAR(220) NOT NULL,
    extension_name VARCHAR(10) NOT NULL,
    type VARCHAR(30) NOT NULL,
    description TEXT,
    preload BOOLEAN NOT NULL DEFAULT false,
    need_stream BOOLEAN,
    tag VARCHAR(10),
    CONSTRAINT fk_game_resoure_screenplay FOREIGN KEY (screenplay_id) REFERENCES screenplay(id)
);

-- 插入游戏资源 mock 数据
INSERT INTO game_resoure (screenplay_id, name, path, extension_name, type, description, preload, need_stream, tag) VALUES
(1, '星空背景', '/resources/sky1.jpg', 'jpg', 'background', '美丽的星空背景图片', true, null, null),
(1, '背景音乐', '/resources/bgm1.mp3', 'mp3', 'audio', '主题背景音乐', false, false, 'bgm'),
(2, '角色立绘', '/resources/char1.png', 'png', 'character_image', '主角立绘图片', true, null, null),
(3, '宫廷角色卡', '/resources/card1.jpg', 'jpg', 'character_card', '宫廷角色卡图片', false, null, null),
(5, '丧尸音效', '/resources/sfx1.mp3', 'mp3', 'audio', '丧尸出现音效', false, true, 'sfx');

-- ========================================
-- 章节表 (chapter)
-- ========================================
CREATE TABLE IF NOT EXISTS chapter (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    "index" INTEGER NOT NULL,
    description TEXT NOT NULL DEFAULT '',
    screenplay_id BIGINT NOT NULL,
    CONSTRAINT fk_chapter_screenplay FOREIGN KEY (screenplay_id) REFERENCES screenplay(id)
);

-- 插入章节 mock 数据
INSERT INTO chapter (title, "index", description, screenplay_id) VALUES
('第一章：启程', 1, '主角开始了他的冒险旅程', 1),
('第二章：相遇', 2, '在旅途中遇到了神秘的伙伴', 1),
('第一章：失踪案', 1, '接到一起神秘的失踪案件', 2),
('第二章：线索', 2, '发现了重要线索', 2),
('第一章：入宫', 1, '主角被选入宫廷', 3);

-- ========================================
-- 场景表 (scene)
-- ========================================
CREATE TABLE IF NOT EXISTS scene (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    "index" INTEGER NOT NULL,
    tasks JSONB NOT NULL DEFAULT '{}',
    chapter_id BIGINT NOT NULL,
    CONSTRAINT fk_scene_chapter FOREIGN KEY (chapter_id) REFERENCES chapter(id)
);

-- 插入场景 mock 数据
INSERT INTO scene (title, description, "index", tasks, chapter_id) VALUES
('太空港', '在繁忙的太空港中准备出发', 1, '{"before_each": [], "after_each": []}', 1),
('飞船内部', '登上飞船，准备起飞', 2, '{"before_each": [], "after_each": []}', 1),
('废弃仓库', '来到废弃的仓库寻找线索', 1, '{"before_each": [], "after_each": []}', 3),
('办公室', '在办公室整理线索', 2, '{"before_each": [], "after_each": []}', 3),
('城门口', '到达京城门口', 1, '{"before_each": [], "after_each": []}', 5);

-- ========================================
-- AI 对话数据表 (ai_dialogue_data)
-- ========================================
CREATE TABLE IF NOT EXISTS ai_dialogue_data (
    id BIGSERIAL PRIMARY KEY,
    core_task TEXT NOT NULL DEFAULT '',
    max_rounds INTEGER NOT NULL DEFAULT 10,
    player_name VARCHAR(100) NOT NULL DEFAULT '',
    character_setup_prompts JSONB NOT NULL DEFAULT '{}',
    jump_prompts JSONB NOT NULL DEFAULT '{}',
    script_id BIGINT,
    CONSTRAINT fk_ai_dialogue_script FOREIGN KEY (script_id) REFERENCES script(id)
);

-- 插入 AI 对话数据 mock 数据
INSERT INTO ai_dialogue_data (core_task, max_rounds, player_name, character_setup_prompts, jump_prompts, script_id) VALUES
('帮助玩家了解飞船的基本操作', 10, '玩家1', '{"character1": {"memory": "", "personality": "友好热情", "goal": "帮助新手玩家", "status_prompts": {}}}', '{}', 1),
('引导玩家进行角色对话', 15, '玩家2', '{"character2": {"memory": "见过主角一次", "personality": "神秘高冷", "goal": "隐藏自己的身份", "status_prompts": {}}}', '{}', 2),
('提供案件线索提示', 8, '玩家3', '{"character3": {"memory": "熟悉案件详情", "personality": "专业严谨", "goal": "协助调查", "status_prompts": {}}}', '{}', 3),
('提供宫廷礼仪指导', 12, '玩家4', '{"character4": {"memory": "了解宫廷规矩", "personality": "温和有礼", "goal": "帮助主角适应", "status_prompts": {}}}', '{}', 4),
('提供生存建议', 20, '玩家5', '{"character5": {"memory": "经验丰富的幸存者", "personality": "谨慎机智", "goal": "保护队友", "status_prompts": {}}}', '{}', 5);

-- ========================================
-- 存档表 (save)
-- ========================================
CREATE TABLE IF NOT EXISTS save (
    id BIGSERIAL PRIMARY KEY,
    slot_id SMALLINT NOT NULL,
    saved_time TIMESTAMP NOT NULL,
    user_id BIGINT NOT NULL,
    screenplay_id BIGINT NOT NULL,
    scene_id BIGINT NOT NULL,
    save_data JSONB NOT NULL DEFAULT '{}',
    CONSTRAINT fk_save_user FOREIGN KEY (user_id) REFERENCES "user"(id),
    CONSTRAINT fk_save_screenplay FOREIGN KEY (screenplay_id) REFERENCES screenplay(id),
    CONSTRAINT fk_save_scene FOREIGN KEY (scene_id) REFERENCES scene(id)
);

-- 插入存档 mock 数据
INSERT INTO save (slot_id, saved_time, user_id, screenplay_id, scene_id, save_data) VALUES
(1, '2024-01-15 10:00:00', 1, 1, 1, '{"character_statuses": {}, "node_modifications": {}, "unlocked_character_card_ids": [], "ending_ids": []}'),
(2, '2024-01-15 11:00:00', 1, 2, 3, '{"character_statuses": {"角色1": 50}, "node_modifications": {}, "unlocked_character_card_ids": [1], "ending_ids": []}'),
(1, '2024-01-16 14:00:00', 2, 1, 2, '{"character_statuses": {}, "node_modifications": {}, "unlocked_character_card_ids": [], "ending_ids": []}'),
(3, '2024-01-17 09:00:00', 3, 3, 5, '{"character_statuses": {"皇帝": 80}, "node_modifications": {}, "unlocked_character_card_ids": [2], "ending_ids": []}'),
(1, '2024-01-18 16:00:00', 5, 5, 1, '{"character_statuses": {}, "node_modifications": {}, "unlocked_character_card_ids": [], "ending_ids": [1]}');

-- ========================================
-- 中间表：剧本-设定关系
-- ========================================
CREATE TABLE IF NOT EXISTS screenplay_play_preset_relation (
    screenplay_id BIGINT NOT NULL,
    preset_id BIGINT NOT NULL,
    PRIMARY KEY (screenplay_id, preset_id),
    CONSTRAINT fk_relation_screenplay FOREIGN KEY (screenplay_id) REFERENCES screenplay(id) ON DELETE CASCADE,
    CONSTRAINT fk_relation_preset FOREIGN KEY (preset_id) REFERENCES play_preset(id) ON DELETE CASCADE
);

-- 插入中间表 mock 数据
INSERT INTO screenplay_play_preset_relation (screenplay_id, preset_id) VALUES
(1, 1),
(1, 2),
(2, 5),
(3, 3),
(3, 4);

-- ========================================
-- 中间表：场景-脚本关系
-- ========================================
CREATE TABLE IF NOT EXISTS scene_script_relation (
    scene_id BIGINT NOT NULL,
    script_id BIGINT NOT NULL,
    PRIMARY KEY (scene_id, script_id),
    CONSTRAINT fk_scene_relation_scene FOREIGN KEY (scene_id) REFERENCES scene(id) ON DELETE CASCADE,
    CONSTRAINT fk_scene_relation_script FOREIGN KEY (script_id) REFERENCES script(id) ON DELETE CASCADE
);

-- 插入场景-脚本中间表 mock 数据
INSERT INTO scene_script_relation (scene_id, script_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- ========================================
-- 中间表：用户-剧本交互关系
-- ========================================
CREATE TABLE IF NOT EXISTS user_screenplay_interact_relation (
    user_id BIGINT NOT NULL,
    screenplay_id BIGINT NOT NULL,
    interaction_type VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY (user_id, screenplay_id, interaction_type),
    CONSTRAINT fk_interact_user FOREIGN KEY (user_id) REFERENCES "user"(id) ON DELETE CASCADE,
    CONSTRAINT fk_interact_screenplay FOREIGN KEY (screenplay_id) REFERENCES screenplay(id) ON DELETE CASCADE
);

-- 插入用户-剧本交互关系 mock 数据
INSERT INTO user_screenplay_interact_relation (user_id, screenplay_id, interaction_type, created_at) VALUES
(1, 1, 'like', '2024-01-15 10:00:00'),
(1, 2, 'favorite', '2024-01-15 11:00:00'),
(2, 1, 'like', '2024-01-16 14:00:00'),
(3, 3, 'favorite', '2024-01-17 09:00:00'),
(5, 5, 'like', '2024-01-18 16:00:00');

-- ========================================
-- 创建索引以提高查询性能
-- ========================================
CREATE INDEX IF NOT EXISTS idx_screenplay_author ON screenplay(author_uid);
CREATE INDEX IF NOT EXISTS idx_chapter_screenplay ON chapter(screenplay_id);
CREATE INDEX IF NOT EXISTS idx_scene_chapter ON scene(chapter_id);
CREATE INDEX IF NOT EXISTS idx_game_resoure_screenplay ON game_resoure(screenplay_id);
CREATE INDEX IF NOT EXISTS idx_game_resoure_type ON game_resoure(type);
CREATE INDEX IF NOT EXISTS idx_ai_dialogue_script ON ai_dialogue_data(script_id);
CREATE INDEX IF NOT EXISTS idx_save_user ON save(user_id);
CREATE INDEX IF NOT EXISTS idx_save_screenplay ON save(screenplay_id);
CREATE INDEX IF NOT EXISTS idx_play_preset_type ON play_preset(type);

-- ========================================
-- 初始化完成
-- ========================================
