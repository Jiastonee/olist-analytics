# Olist 电商经营分析

![MySQL](https://img.shields.io/badge/MySQL-8.0-blue)
![Python](https://img.shields.io/badge/Python-3.8+-green)
![Tableau](https://img.shields.io/badge/Tableau-Public-orange)

本项目基于公开的 Olist Brazilian E-Commerce 数据集，复现企业常见的数据分析全流程：从数据建模、指标体系搭建，到专题分析与可视化看板输出。

🔗 **Tableau 看板（可在线查看）**：https://public.tableau.com/app/profile/jia.stone/viz/olist_17739219739980/1

---

## ⭐ 项目亮点

| 技能领域 | 具体内容 |
|----------|----------|
| **数据建模** | 星型模型设计，事实表 + 用户主题表 |
| **指标体系** | 定义 GMV / 差评率 / 准时率 / 复购率等核心口径 |
| **专题分析** | 留存 Cohort / 转化漏斗 / RFM 分层 / 差评根因 |
| **BI 可视化** | Tableau 7 页经营分析看板（含交互筛选） |
| **Python** | 数据质量检查、缺失值与异常值报告 |

---

## 📊 核心结论与业务建议

### 经营概览
- 平台 GMV 从 2016年9月 持续增长，2017年11月达到峰值 16,411
- Top 品类：美妆健康（beleza_saude）GMV 141万，遥遥领先
- Top 地区：圣保罗州（SP）GMV 576万，占总 GMV 约 43%
- 💡 **建议**：优先保障 SP 州和美妆品类的物流时效，稳住核心盘

### 转化漏斗
- 下单 99,441 → 支付确认 98.76% → 已发货 98.21% → 已送达 97.02%
- 整体履约率良好，主要流失发生在支付环节
- 💡 **建议**：优化支付页面体验，排查支付失败原因

### 用户体验
- 准时配送差评率仅 9.33%
- 延迟 1-3 天差评率升至 32.24%
- 延迟 8 天以上差评率高达 79.65%
- 💡 **建议**：以 3 天为预警阈值，建立延迟订单主动干预机制

### 用户留存
- 总用户 93,358，复购用户 1,693，复购率 1.81%
- M1 留存率仅 0.38%，用户粘性极低
- RFM 分层：高价值用户 1,202 人（1.3%），流失高价值用户 13,095 人
- 💡 **建议**：对流失高价值用户优先做召回，ROI 高于拉新

---

## 📁 项目结构

```
olist-analytics/
├── README.md                        # 项目说明
│
├── sql/                             # SQL 脚本
│   ├── 00_setup/                    # 建表与数据导入
│   ├── 10_model/                    # 数据建模（事实表/主题表）
│   └── 20_analysis/                 # 专题分析（漏斗/留存/RFM）
│
├── notebooks/                       # Python 分析
│   └── data_quality_checks.ipynb   # 数据质量检查报告
│
└── docs/                            # 文档
    └── metric_dict.md               # 指标口径说明
```

> ⚠️ 原始数据集不含在仓库中，请从 [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) 自行下载
****

## 🛠️ 技术栈

| 类别 | 工具 | 用途 |
|------|------|------|
| 数据库 | MySQL 8.0 | 数据存储、建模、分析 |
| 编程语言 | Python 3.8+ | 数据清洗与质量检查 |
| 核心库 | pandas, sqlalchemy | 数据处理 |
| 可视化 | Tableau Public | 交互式经营看板 |
| 版本控制 | Git / GitHub | 代码管理 |

---

## 📦 数据来源

**Olist Brazilian E-Commerce Public Dataset**（Kaggle）
- 约 100,000 订单，时间跨度 2016-2018
- 9 张关联表（订单、商品、支付、评价、物流等）
- 🔗 [数据集下载地址](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

