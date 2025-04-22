from django.shortcuts import render
from django.conf import settings
from django.http import HttpResponse
from django.contrib import messages
from .forms import UserRegistrationForm
from .models import UserRegistrationModel

import pandas as pd
import numpy as np

# Create your views here.




def UserRegisterActions(request):
    if request.method == 'POST':
        form = UserRegistrationForm(request.POST)
        if form.is_valid():
            print('Data is Valid')
            form.save()
            messages.success(request, 'You have been successfully registered')
            form = UserRegistrationForm()
            return render(request, 'UserRegistrations.html', {'form': form})
        else:
            messages.success(request, 'Email or Mobile Already Existed')
            print("Invalid form")
    else:
        form = UserRegistrationForm()
    return render(request, 'UserRegistrations.html', {'form': form})


def UserLoginCheck(request):
    if request.method =='POST':
        loginid=request.POST.get('loginid')
        pswd=request.POST.get('pswd')
        print("Login ID = ", loginid, ' Password = ', pswd)
        try:
            check = UserRegistrationModel.objects.get(
                loginid=loginid, password=pswd)
            status = check.status
            print('Status is = ', status)
            if status == "activated":
                request.session['id'] = check.id
                request.session['loggeduser'] = check.name
                request.session['loginid'] = loginid
                request.session['email'] = check.email
                print("User id At", check.id, status)
                return render(request, 'users/userhome.html', {})
            else:
                messages.success(request, 'Your Account Not at activated')
                return render(request, 'userlogin.html')
        except Exception as e:
            print('Exception is ', str(e))
            pass
            messages.success(request, 'Invalid Login id and password')
        return render(request, 'userlogin.html', {})


def UserHome(request):

    return render(request, 'users/userhome.html', {})



def viewData(request):
    import pandas as pd
    from django.conf import settings
    import os
    path=os.path.join(settings.MEDIA_ROOT,'AAPL.csv')
    df=pd.read_csv(path)
    df=df.to_html
    path = os.path.join(settings.MEDIA_ROOT,'IBM.csv')
    auto_df = pd .read_csv(path)
    auto_df = auto_df.to_html
    return render(request, 'users/userviewdata.html', {'data': df, "auto":auto_df})

def viewData1(request):
    import pandas as pd
    from django.conf import settings
    import os
    path=os.path.join(settings.MEDIA_ROOT,'BTC-Daily.csv')
    df=pd.read_csv(path)
    df=df.to_html
    path = os.path.join(settings.MEDIA_ROOT,'oil.csv')
    auto_df = pd .read_csv(path)
    auto_df = auto_df.to_html
    return render(request, 'users/userviewdata.html', {'data': df, "auto":auto_df})

def EdaAnalysis(request):


    return render(request, "users/eda_images.html", {})


def AAPLML(request):
    from .algorithms import AlgorithmUtility
    accuracy, recall, f1score = AlgorithmUtility.calc_random_forest()
    accuracy1, recall1, f1score1 = AlgorithmUtility.calc_naive_bayes_classifier()
    print("====",accuracy)
    print("====", accuracy1)
    return render(request, 'users/AAPL.html',
                  {'accuracy': accuracy, "recall": recall, "f1score": f1score,'accuracy1': accuracy1, "recall1": recall1, "f1score1": f1score1})

def OilML(request):
    from .algorithms import AlgorithmUtility1
    accuracy, recall, f1score = AlgorithmUtility1.calc_random_forest()
    accuracy1,  f1score1 = AlgorithmUtility1.calc_naive_bayes_classifier()
    print("====", accuracy)
    print("====", accuracy1)
    return render(request, 'users/Oil.html',
                  {'accuracy': accuracy,"recall": recall, "f1score": f1score,'accuracy1': accuracy1, "f1score1": f1score1})



def ANNML(request):
    import pandas as pd
    from sklearn.model_selection import train_test_split
    from django.conf import settings
    from sklearn.metrics import precision_score
    from sklearn.metrics import recall_score
    from sklearn.metrics import f1_score
    from sklearn.metrics import accuracy_score
    from sklearn.metrics import confusion_matrix

    path = settings.MEDIA_ROOT + "//" + "IBM.csv"
    df = pd.read_csv(path)
    X = df.iloc[:, :-1].values  # indipendent variable
    y = df.iloc[:, -1].values  # Dependent variable
    X_train, X_test, y_train, y_test = train_test_split(X, y, train_size=0.2, random_state=0)
    # Visualize training history
    from tensorflow.keras.models import Sequential
    from tensorflow.keras.layers import Dense
    import matplotlib.pyplot as plt
    import numpy as np
    # load pima indians dataset
    # dataset = np.loadtxt("pima-indians-diabetes.csv", delimiter=",")
    # split into input (X) and output (Y) variables
    # X = dataset[:, 0:8]
    # Y = dataset[:, 8]
    # create model
    model = Sequential()
    model.add(Dense(1, input_dim=5, activation='relu'))
    model.add(Dense(1, activation='relu'))
    model.add(Dense(1, activation='sigmoid'))
    # Compile model
    model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])
    # Fit the model
    history=model.fit(X_train, y_train, epochs=100, validation_data=(X_test, y_test))
    # list all data in history
    print(history.history.keys())
    # summarize history for accuracy
    plt.plot(history.history['accuracy'])
    plt.plot(history.history['val_accuracy'])
    plt.title('model accuracy')
    plt.ylabel('accuracy')
    plt.xlabel('epoch')
    plt.legend(['train', 'test'], loc='upper left')
    plt.show()
    # summarize history for loss
    plt.plot(history.history['loss'])
    plt.plot(history.history['val_loss'])
    plt.title('model loss')
    plt.ylabel('loss')
    plt.xlabel('epoch')
    plt.legend(['train', 'test'], loc='upper left')
    plt.legend()
    return render(request,'users/ann.html',{})









