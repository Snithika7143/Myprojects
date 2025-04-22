import pandas as pd
from sklearn.model_selection import train_test_split
from django.conf import settings
from sklearn.metrics import precision_score
from sklearn.metrics import recall_score
from sklearn.metrics import f1_score
from sklearn.metrics import accuracy_score
from sklearn.metrics import confusion_matrix

path = settings.MEDIA_ROOT + "//" + "oil.csv"
df = pd.read_csv(path)
X = df.iloc[:, :-1].values  # indipendent variable
y = df.iloc[:, -1].values  # Dependent variable
X_train, X_test, y_train, y_test = train_test_split(X, y, train_size=0.2, random_state=0)




def calc_random_forest():
    print("*" * 25, "Random Forest Classification")
    from sklearn.ensemble import RandomForestClassifier
    model = RandomForestClassifier()
    model.fit(X_train, y_train)  # Trained wih 80% Data
    y_pred = model.predict(X_test)
    accuracy = accuracy_score(y_test, y_pred)
    print('RF Accuracy:', accuracy)
    cm = confusion_matrix(y_test, y_pred)
    recall = recall_score(y_test, y_pred)
    print('RF Recall Score:', recall)
    f1score = f1_score(y_test, y_pred)
    print('RF F1-Score:', f1score)
    return accuracy, recall, f1score


def calc_naive_bayes_classifier():
    print("*"*25,"Naive Bayes")
    from sklearn.naive_bayes import GaussianNB
    model = GaussianNB()
    model.fit(X_train, y_train)  # Trained wih 80% Data
    y_pred = model.predict(X_test)
    accuracy1 = accuracy_score(y_test, y_pred)
    print('NB Accuracy:', accuracy1)
    cm = confusion_matrix(y_test, y_pred)
    f1score1 = f1_score(y_test, y_pred)
    print('NB F1-Score:', f1score1)
    return accuracy1,f1score1




