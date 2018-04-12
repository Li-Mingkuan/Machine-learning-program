
# ��������
wbcd <- read.csv("wisc_bc_data.csv", stringsAsFactors = FALSE)

# �鿴�ṹ
str(wbcd)

# ɾ�����
wbcd <- wbcd[-1]

# �鿴Ƶ��
table(wbcd$diagnosis)

# ת����������Ϊ�������ͣ�ԭʼ�ַ�B M ��Ӧ "Benign", "Malignant"
wbcd$diagnosis <- factor(wbcd$diagnosis, levels = c("B", "M"),
                         labels = c("Benign", "Malignant"))

# ����prop.table����ת��ΪƵ��ΪƵ��
round(prop.table(table(wbcd$diagnosis)) * 100, digits = 1)

# ��鲿����������Ϣ
summary(wbcd[c("radius_mean", "area_mean", "smoothness_mean")])

# ��׼���������͵�ֵ����0��1֮��
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

# ���Ա�׼������
normalize(c(1, 2, 3, 4, 5))
normalize(c(10, 20, 30, 40, 50))

# ��׼����2��31������
# lapply������һ�������ѭ����������֮һ��������list��data.frame���ݼ�����ѭ���������غ�X����ͬ����list�ṹ��Ϊ�������ͨ��lapply�Ŀ�ͷ�ĵ�һ����ĸ��l���Ϳ����жϷ��ؽ���������͡�

wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize))

# ���apply���
summary(wbcd_n$area_mean)

# ����ѧϰ���Ͳ��Լ�
wbcd_train <- wbcd_n[1:469, ]
wbcd_test <- wbcd_n[470:569, ]

# ��ȡԭʼ���ݵĵ�һ�У����ҷ���wbcd_train_labels ��wbcd_test_labels ��������

wbcd_train_labels <- wbcd[1:469, 1]
wbcd_test_labels <- wbcd[470:569, 1]

## STEP 3����ģ�ͣ�ֱ�ӻ��Ԥ����

# load the "class" library
library(class)
#����knn����������Ϊѧϰ�������Լ���ѧϰ����ǩ��kֵ
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k = 21)

## Step 4: ģ������
# load the "gmodels" library
library(gmodels)

# ����CrossTable������� predicted . actual �����prop.chisq = FALSE��ʾ������صĿ������
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,
           prop.chisq = FALSE)

## Step 5: ����ģ������

# ʹ�� scale() ������� z-score ��׼����ע��scale�����Դ�lapply����
wbcd_z <- as.data.frame(scale(wbcd[-1]))

# �����
summary(wbcd_z$area_mean)

# ����ѵ�����Ͳ��Լ�
wbcd_train <- wbcd_z[1:469, ]
wbcd_test <- wbcd_z[470:569, ]

# �ٴδ���ģ�ͼ�Ԥ��
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k = 21)

# �ٴδ��������
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,
           prop.chisq = FALSE)

# ���Բ�ͬ��Kֵ������δ����ѵ�K
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
