import json
import numpy as np
import tensorflow as tf

model_dir = 'koogu_narw_model'

# Audio clips as model inputs. Must be an NxS vector of N clips (N can be 1, if
# loading a single clip). S, in this model's case, is 2250 since it expects each
# input to be 2.25s long segment of audio sampled at 1000 Hz.
# The below code loads 2 pre-extracted sample clips, from a json file. One clip
# contains a NARW upcall and the other doesn't. The second line converts the
# clips (which are python lists) into a 2x2250 numpy array of float32 type
# values (as expected by typical tensorflow models).
# You could replace the below two lines with code with your own logic to read
# contents of an audio file, resample to 1000 Hz, and break-up into segments of
# 2.25 s duration (with or without overlap).
sample_audio_clips = json.load(open('test_audio_samples.json', 'r'))
sample_audio_clips = np.asarray(sample_audio_clips, dtype=np.float32)

# Load the model from disk
model = tf.saved_model.load(model_dir)

# Load the "signature" that accepts raw audio segments as inputs
infer_fn = model.signatures['with_transformation']

# Run inferences with audio segments, and extract the corresponding
# detection/classification 'scores'.
# The "numpy()" at the end converts scores from tensors to a numpy array
scores = infer_fn(inputs=sample_audio_clips)['scores'].numpy()

# print(scores)     # will show 2x2 vector. One row per clip, one col per class.

# OPTIONAL:
# Load the list of (intended) human-readable class names to associate each
# column of output to.
# Models trained with Koogu have this list as a json file under the "assets"
# directory. We can move this around if PAMGuard's ML module needs it to be
# someplace else.
class_names = json.load(open('koogu_narw_model/assets/classes_list.json', 'r'))

for clip_idx in [0, 1]:
    print(f'Clip #{clip_idx + 1}:')
    print(f'   {class_names[0]} - {scores[clip_idx, 0]:.2f}')
    print(f'   {class_names[1]} - {scores[clip_idx, 1]:.2f}')
