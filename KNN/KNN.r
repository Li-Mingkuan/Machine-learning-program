
# 导入数据
wbcd <- read.csv("wisc_bc_data.csv", stringsAsFactors = FALSE)

# 查看结构
str(wbcd)

# 删除编号
wbcd <- wbcd[-1]

# 查看频数
table(wbcd$diagnosis)

# 转换分类属性为因子类型，原始字符B M 对应 "Benign", "Malignant"
wbcd$diagnosis <- factor(wbcd$diagnosis, levels = c("B", "M"),
                         labels = c("Benign", "Malignant"))

# 调用prop.table函数转换为频数为频率
round(prop.table(table(wbcd$diagnosis)) * 100, digits = 1)

# 检查部分特征的信息
summary(wbcd[c("radius_mean", "area_mean", "smoothness_mean")])

# 标准化数据类型的值落在0到1之间
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

# 测试标准化函数
normalize(c(1, 2, 3, 4, 5))
normalize(c(10, 20, 30, 40, 50))

# 标准化第2到31列数据
# lapply函数是一个最基础循环操作函数之一，用来对list、data.frame数据集进行循环，并返回和X长度同样的list结构作为结果集，通过lapply的开头的第一个字母’l’就可以判断返回结果集的类型。

wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize))

# 检查apply结果
summary(wbcd_n$area_mean)

# 创建学习集和测试集
wbcd_train <- wbcd_n[1:469, ]
wbcd_test <- wbcd_n[470:569, ]

# 获取原始数据的第一列，并且放入wbcd_train_labels ，wbcd_test_labels 两个变量

wbcd_train_labels <- wbcd[1:469, 1]
wbcd_test_labels <- wbcd[470:569, 1]

## STEP 3创建模型，直接获得预测结果

# load the "class" library
library(class)
#调用knn函数，参数为学习集，测试集，学习集标签，k值
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k = 21)

## Step 4: 模型评估
# load the "gmodels" library
library(gmodels)

# 调用CrossTable函数获得 predicted . actual 交叉表，prop.chisq = FALSE表示不做相关的卡方检测
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,
           prop.chisq = FALSE)

## Step 5: 提升模型性能

# 使用 scale() 函数获得 z-score 标准化，注意scale函数自带lapply能力
wbcd_z <- as.data.frame(scale(wbcd[-1]))

# 检查结果
summary(wbcd_z$area_mean)

# 创建训练集和测试集
wbcd_train <- wbcd_z[1:469, ]
wbcd_test <- wbcd_z[470:569, ]

# 再次创建模型及预测
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k = 21)

# 再次创建交叉表
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,
           prop.chisq = FALSE)

# 尝试不同的K值，方便未来最佳的K
wbcd_train <- wbcd_n[1:469, ]
wbcd_test <- wbcd_n[470:569, ]

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, cl = wbcd_train_labels, k=1)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE)

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, cl = wbcd_train_labels, k=5)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE)

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, cl = wbcd_train_labels, k=11)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE)

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, cl = wbcd_train_labels, k=15)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE)

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, cl = wbcd_train_labels, k=21)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE)

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, cl = wbcd_train_labels, k=27)
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq=FALSE)
