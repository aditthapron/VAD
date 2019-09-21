#!/usr/bin/env python
# coding: utf-8

# In[1]:


import glob
import math
import librosa as rosa
import numpy as np
import os
from scipy.io import loadmat
from scipy.signal import resample
from sklearn.preprocessing import StandardScaler,MinMaxScaler
from sklearn.model_selection import train_test_split
import utils

# In[2]:


def MFCC_extractor(data_dir,save_dir,sound_len):
    os.system("mkdir " + save_dir + "/Normalize_Factor")
    os.system("mkdir " + save_dir + "/Labels")
    os.system("mkdir " + save_dir)
    audio_sr = 16000
    

    audio_list = glob.glob(data_dir+"/*.wav", recursive=True)
    label_list = glob.glob(data_dir+"/*.mat", recursive=True)

    winlen = math.ceil(audio_sr*25*0.001)
    winstep = math.ceil(audio_sr*10*0.001)
    train_data = np.array([])
    train_y = np.array([])
   
    for i in range(len(audio_list)):
        x= []
        data,_ = rosa.load(audio_list[i],audio_sr)
       
        
        n_frame =  int(len(data)/ (sound_len * audio_sr))
        data = data[:int(n_frame * sound_len * audio_sr)]
        data = np.reshape(data,(n_frame,int(sound_len * audio_sr)))
        
        for j in range(n_frame):
            mfcc = rosa.feature.mfcc(data[j],audio_sr,n_mfcc=8, n_fft=1024, hop_length=256).reshape((1,8,-1))
            try:
                x = np.concatenate((x,mfcc))
            except:
                x = mfcc
        x = np.swapaxes(x,1,2)
        y = loadmat(label_list[i])['y_label'].flatten()
        y = y[:int(n_frame * sound_len * audio_sr)]
        y = np.array(resample(y,x.shape[0]*x.shape[1],axis=0)>0.5,dtype=int)
        y = np.reshape(y,(n_frame,-1))
        try:
            train_y = np.concatenate((train_y,y))
            train_data = np.concatenate((train_data,x))
            
        except Exception as e:
            train_y = y
            train_data = x
        
    
    
    return train_data,train_y


class DataReader(object):

    def __init__(self, input_dir, output_dir, norm_dir, w=19, u=9, name=None):
        # print(name + " data reader initialization...")
        X,y = MFCC_extractor("Recorded_data",".",20)
        X_shape = X.shape
        y_shape = y.shape
        X = X.reshape(X_shape[0],X_shape[1]*X_shape[2])
        y = y.reshape(X_shape[0],-1)
        X_train, X_test, self.y_train, self.y_test = train_test_split(X, y, test_size=0.1, random_state=0)
        X_train, X_val, self.y_train, self.y_val = train_test_split(X_train, self.y_train, test_size=0.09, random_state=0)
        #normalization
        scaler = MinMaxScaler()
        scaler.fit(X_train)
        self.X_train = scaler.transform(X_train).reshape((-1,X_shape[2]))
        self.X_val = scaler.transform(X_val).reshape((-1,X_shape[2]))
        self.X_test = scaler.transform(X_test).reshape((-1,X_shape[2]))
        self.y_train = self.y_train.reshape((-1,1))
        self._w = w
        self._u = u
        self.eof = False
        self.file_change = False
        self.num_samples = 0

        self._inputs = 0
        self._outputs = 0

        self._epoch = 1
        self._num_file = 0
        self._start_idx = self._w
        self.file_change = False
        self.num_samples = 0

        self._inputs = 0
        self._outputs = 0

        self._epoch = 1
        self._num_file = 0
        self._start_idx = self._w

        self.raw_inputs = 0  # adding part
        # print("Done.")
        # print("BOF : " + self._name + " file_" + str(self._num_file).zfill(2))

    @staticmethod
    def _padding(inputs, batch_size, w_val):
        pad_size = batch_size - inputs.shape[0] % batch_size
        #import pdb;pdb.set_trace();
        inputs = np.concatenate((inputs.astype(np.float32), np.zeros((pad_size, inputs.shape[1])).astype(np.float32)))

        window_pad = np.zeros((w_val, inputs.shape[1]))
        inputs = np.concatenate((window_pad, inputs, window_pad), axis=0)
        return inputs

    def next_batch(self, batch_size):

       
        self._inputs = self._padding(self.X_train[self._start_idx:self._start_idx+batch_size], batch_size, self._w)

        self._outputs = self._padding(self.y_train[self._start_idx:self._start_idx+batch_size], batch_size, self._w)

        self.num_samples = np.shape(self._outputs)[0]
        inputs = self._inputs[self._start_idx - self._w:self._start_idx + batch_size + self._w, :]
        inputs = utils.bdnn_transform(inputs, self._w, self._u)
        inputs = inputs[self._w: -self._w, :]

        outputs = self._outputs[self._start_idx - self._w:self._start_idx + batch_size + self._w, :]
        outputs = utils.bdnn_transform(outputs, self._w, self._u)
        outputs = outputs[self._w: -self._w, :]

        self._start_idx += batch_size
        if self._start_idx+batch_size > self.X_train.shape[0]:
            self._start_idx = 0
        return inputs, outputs

