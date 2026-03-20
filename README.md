# Olist 电商经营分析

![MySQL](https://img.shields.io/badge/MySQL-8.0-blue)
![Python](https://img.shields.io/badge/Python-3.8+-green)
![Tableau](https://img.shields.io/badge/Tableau-Public-orange)

本项目基于公开的 Olist Brazilian E-Commerce 数据集，复现企业常见的数据分析全流程。

🔗 **Tableau 看板**：https://public.tableau.com/app/profile/jia.stone/viz/olist_17739219739980/1

---

## 项目亮点

- **数据建模**：星型模型设计，事实表 + 用户主题表
- **指标体系**：定义 GMV / 差评率 / 准时率 / 复购率等核心口径
- **专题分析**：留存 Cohort / 转化漏斗 / RFM 分层 / 差评根因
- **可视化看板**：Tableau 7 页经营分析看板
- **Python 分析**：数据质量检查、缺失值与异常值报告

---

## 核心结论

### 经营概览
- 平台 GMV 从 2016年9月 持续增长，2017年11月达到峰值 16,411
- Top 品类：美妆健康（beleza_saude）GMV 141万，遥遥领先
- Top 地区：圣保罗州（SP）GMV 576万，占总 GMV 约 43%

### 转化漏斗
- 下单 99,441 → 支付确认 98.76% → 已发货 98.21% → 已送达 97.02%
- 整体履约率良好，主要流失发生在支付环节

### 用户体验
- 准时配送差评率仅 9.33%
- 延迟 1-3 天差评率升至 32.24%
- 延迟 8 天以上差评率高达 79.65%
- **结论：延迟是差评的核心驱动因素**

### 用户留存
- 总用户 93,358，复购用户 1,693，复购率 1.81%
- M1 留存率仅 0.38%，用户粘性极低
- RFM 分层：高价值用户 1,202 人（1.3%），流失高价值用户 13,095 人

---

## 项目结构
olist-analytics/
├── docs/
│   └── metric_dict.md        # 指标口径说明
├── sql/
│   ├── 00_setup/             # 建表与数据导入
│   ├── 10_model/             # 数据建模（事实表/主题表）
│   └── 20_analysis/          # 专题分析 SQL
├── notebooks/
│   └── data_quality_checks.ipynb  # Python 数据质量检查
└── README.md

---

## 技术栈

- **数据库**：MySQL 8.0
- **数据处理**：Python 3.8+（pandas、sqlalchemy）
- **可视化**：Tableau Public
- **版本控制**：Git / GitHub
