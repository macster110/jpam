��9
�*�*
.
Abs
x"T
y"T"
Ttype:

2	
D
AddV2
x"T
y"T
z"T"
Ttype:
2	��
B
AssignVariableOp
resource
value"dtype"
dtypetype�
�
AvgPool

value"T
output"T"
ksize	list(int)(0"
strides	list(int)(0""
paddingstring:
SAMEVALID"-
data_formatstringNHWC:
NHWCNCHW"
Ttype:
2
~
BiasAdd

value"T	
bias"T
output"T" 
Ttype:
2	"-
data_formatstringNHWC:
NHWCNCHW
N
Cast	
x"SrcT	
y"DstT"
SrcTtype"
DstTtype"
Truncatebool( 
h
ConcatV2
values"T*N
axis"Tidx
output"T"
Nint(0"	
Ttype"
Tidxtype0:
2	
7
Conj

input"T
output"T"
Ttype0:
2
8
Const
output"dtype"
valuetensor"
dtypetype
�
Conv2D

input"T
filter"T
output"T"
Ttype:	
2"
strides	list(int)"
use_cudnn_on_gpubool(",
paddingstring:
SAMEVALIDEXPLICIT""
explicit_paddings	list(int)
 "-
data_formatstringNHWC:
NHWCNCHW" 
	dilations	list(int)

,
Cos
x"T
y"T"
Ttype:

2
W

ExpandDims

input"T
dim"Tdim
output"T"	
Ttype"
Tdimtype0:
2	
^
Fill
dims"
index_type

value"T
output"T"	
Ttype"

index_typetype0:
2	
A
FloorDiv
x"T
y"T
z"T"
Ttype:
2	
?
FloorMod
x"T
y"T
z"T"
Ttype:
2	
�
FusedBatchNormV3
x"T

scale"U
offset"U	
mean"U
variance"U
y"T

batch_mean"U
batch_variance"U
reserve_space_1"U
reserve_space_2"U
reserve_space_3"U"
Ttype:
2"
Utype:
2"
epsilonfloat%��8"&
exponential_avg_factorfloat%  �?";
data_formatstringNHWC:
NHWCNCHWNDHWCNCDHW"
is_trainingbool(
�
GatherV2
params"Tparams
indices"Tindices
axis"Taxis
output"Tparams"

batch_dimsint "
Tparamstype"
Tindicestype:
2	"
Taxistype:
2	
.
Identity

input"T
output"T"	
Ttype
,
Log
x"T
y"T"
Ttype:

2
q
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:

2	
�
Max

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( " 
Ttype:
2	"
Tidxtype0:
2	
>
Maximum
x"T
y"T
z"T"
Ttype:
2	
�
Mean

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( " 
Ttype:
2	"
Tidxtype0:
2	
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(�
?
Mul
x"T
y"T
z"T"
Ttype:
2	�

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
_
Pad

input"T
paddings"	Tpaddings
output"T"	
Ttype"
	Tpaddingstype0:
2	
�
PartitionedCall
args2Tin
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc"
configstring "
config_protostring "
executor_typestring 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
s
RFFT
input"Treal

fft_length
output"Tcomplex"
Trealtype0:
2"
Tcomplextype0:
2
e
Range
start"Tidx
limit"Tidx
delta"Tidx
output"Tidx"
Tidxtype0:
2		
@
ReadVariableOp
resource
value"dtype"
dtypetype�
S
Real

input"T
output"Tout"
Ttype0:
2"
Touttype0:
2
@
RealDiv
x"T
y"T
z"T"
Ttype:
2	
E
Relu
features"T
activations"T"
Ttype:
2	
[
Reshape
tensor"T
shape"Tshape
output"T"	
Ttype"
Tshapetype0:
2	
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0�
.
Rsqrt
x"T
y"T"
Ttype:

2
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0�
?
Select
	condition

t"T
e"T
output"T"	
Ttype
P
Shape

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
H
ShardedFilename
basename	
shard

num_shards
filename
0
Sigmoid
x"T
y"T"
Ttype:

2
a
Slice

input"T
begin"Index
size"Index
output"T"	
Ttype"
Indextype:
2	
�
SplitV

value"T
size_splits"Tlen
	split_dim
output"T*	num_split"
	num_splitint(0"	
Ttype"
Tlentype0	:
2	
�
StatefulPartitionedCall
args2Tin
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc"
configstring "
config_protostring "
executor_typestring ��
@
StaticRegexFullMatch	
input

output
"
patternstring
�
StridedSlice

input"T
begin"Index
end"Index
strides"Index
output"T"	
Ttype"
Indextype:
2	"

begin_maskint "
end_maskint "
ellipsis_maskint "
new_axis_maskint "
shrink_axis_maskint 
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
<
Sub
x"T
y"T
z"T"
Ttype:
2	
P
	Transpose
x"T
perm"Tperm
y"T"	
Ttype"
Tpermtype0:
2	
�
VarHandleOp
resource"
	containerstring "
shared_namestring "
dtypetype"
shapeshape"#
allowed_deviceslist(string)
 �"serve*2.7.12v2.7.0-217-g2a0f59ecfe68��1
�
Pre_Conv/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape:* 
shared_namePre_Conv/kernel
{
#Pre_Conv/kernel/Read/ReadVariableOpReadVariableOpPre_Conv/kernel*&
_output_shapes
:*
dtype0
�
B1_CF1_BatchNorm/betaVarHandleOp*
_output_shapes
: *
dtype0*
shape:*&
shared_nameB1_CF1_BatchNorm/beta
{
)B1_CF1_BatchNorm/beta/Read/ReadVariableOpReadVariableOpB1_CF1_BatchNorm/beta*
_output_shapes
:*
dtype0
�
B1_CF1_BatchNorm/moving_meanVarHandleOp*
_output_shapes
: *
dtype0*
shape:*-
shared_nameB1_CF1_BatchNorm/moving_mean
�
0B1_CF1_BatchNorm/moving_mean/Read/ReadVariableOpReadVariableOpB1_CF1_BatchNorm/moving_mean*
_output_shapes
:*
dtype0
�
 B1_CF1_BatchNorm/moving_varianceVarHandleOp*
_output_shapes
: *
dtype0*
shape:*1
shared_name" B1_CF1_BatchNorm/moving_variance
�
4B1_CF1_BatchNorm/moving_variance/Read/ReadVariableOpReadVariableOp B1_CF1_BatchNorm/moving_variance*
_output_shapes
:*
dtype0
�
B1_CF1_Conv2D/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape:*%
shared_nameB1_CF1_Conv2D/kernel
�
(B1_CF1_Conv2D/kernel/Read/ReadVariableOpReadVariableOpB1_CF1_Conv2D/kernel*&
_output_shapes
:*
dtype0
�
B1_CF2_BatchNorm/betaVarHandleOp*
_output_shapes
: *
dtype0*
shape:*&
shared_nameB1_CF2_BatchNorm/beta
{
)B1_CF2_BatchNorm/beta/Read/ReadVariableOpReadVariableOpB1_CF2_BatchNorm/beta*
_output_shapes
:*
dtype0
�
B1_CF2_BatchNorm/moving_meanVarHandleOp*
_output_shapes
: *
dtype0*
shape:*-
shared_nameB1_CF2_BatchNorm/moving_mean
�
0B1_CF2_BatchNorm/moving_mean/Read/ReadVariableOpReadVariableOpB1_CF2_BatchNorm/moving_mean*
_output_shapes
:*
dtype0
�
 B1_CF2_BatchNorm/moving_varianceVarHandleOp*
_output_shapes
: *
dtype0*
shape:*1
shared_name" B1_CF2_BatchNorm/moving_variance
�
4B1_CF2_BatchNorm/moving_variance/Read/ReadVariableOpReadVariableOp B1_CF2_BatchNorm/moving_variance*
_output_shapes
:*
dtype0
�
B1_CF2_Conv2D/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape:*%
shared_nameB1_CF2_Conv2D/kernel
�
(B1_CF2_Conv2D/kernel/Read/ReadVariableOpReadVariableOpB1_CF2_Conv2D/kernel*&
_output_shapes
:*
dtype0
�
T1_CF_BatchNorm/betaVarHandleOp*
_output_shapes
: *
dtype0*
shape:*%
shared_nameT1_CF_BatchNorm/beta
y
(T1_CF_BatchNorm/beta/Read/ReadVariableOpReadVariableOpT1_CF_BatchNorm/beta*
_output_shapes
:*
dtype0
�
T1_CF_BatchNorm/moving_meanVarHandleOp*
_output_shapes
: *
dtype0*
shape:*,
shared_nameT1_CF_BatchNorm/moving_mean
�
/T1_CF_BatchNorm/moving_mean/Read/ReadVariableOpReadVariableOpT1_CF_BatchNorm/moving_mean*
_output_shapes
:*
dtype0
�
T1_CF_BatchNorm/moving_varianceVarHandleOp*
_output_shapes
: *
dtype0*
shape:*0
shared_name!T1_CF_BatchNorm/moving_variance
�
3T1_CF_BatchNorm/moving_variance/Read/ReadVariableOpReadVariableOpT1_CF_BatchNorm/moving_variance*
_output_shapes
:*
dtype0
�
T1_CF_Conv2D/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape:*$
shared_nameT1_CF_Conv2D/kernel
�
'T1_CF_Conv2D/kernel/Read/ReadVariableOpReadVariableOpT1_CF_Conv2D/kernel*&
_output_shapes
:*
dtype0
�
B2_CF1_BatchNorm/betaVarHandleOp*
_output_shapes
: *
dtype0*
shape:*&
shared_nameB2_CF1_BatchNorm/beta
{
)B2_CF1_BatchNorm/beta/Read/ReadVariableOpReadVariableOpB2_CF1_BatchNorm/beta*
_output_shapes
:*
dtype0
�
B2_CF1_BatchNorm/moving_meanVarHandleOp*
_output_shapes
: *
dtype0*
shape:*-
shared_nameB2_CF1_BatchNorm/moving_mean
�
0B2_CF1_BatchNorm/moving_mean/Read/ReadVariableOpReadVariableOpB2_CF1_BatchNorm/moving_mean*
_output_shapes
:*
dtype0
�
 B2_CF1_BatchNorm/moving_varianceVarHandleOp*
_output_shapes
: *
dtype0*
shape:*1
shared_name" B2_CF1_BatchNorm/moving_variance
�
4B2_CF1_BatchNorm/moving_variance/Read/ReadVariableOpReadVariableOp B2_CF1_BatchNorm/moving_variance*
_output_shapes
:*
dtype0
�
B2_CF1_Conv2D/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape:*%
shared_nameB2_CF1_Conv2D/kernel
�
(B2_CF1_Conv2D/kernel/Read/ReadVariableOpReadVariableOpB2_CF1_Conv2D/kernel*&
_output_shapes
:*
dtype0
�
B2_CF2_BatchNorm/betaVarHandleOp*
_output_shapes
: *
dtype0*
shape:*&
shared_nameB2_CF2_BatchNorm/beta
{
)B2_CF2_BatchNorm/beta/Read/ReadVariableOpReadVariableOpB2_CF2_BatchNorm/beta*
_output_shapes
:*
dtype0
�
B2_CF2_BatchNorm/moving_meanVarHandleOp*
_output_shapes
: *
dtype0*
shape:*-
shared_nameB2_CF2_BatchNorm/moving_mean
�
0B2_CF2_BatchNorm/moving_mean/Read/ReadVariableOpReadVariableOpB2_CF2_BatchNorm/moving_mean*
_output_shapes
:*
dtype0
�
 B2_CF2_BatchNorm/moving_varianceVarHandleOp*
_output_shapes
: *
dtype0*
shape:*1
shared_name" B2_CF2_BatchNorm/moving_variance
�
4B2_CF2_BatchNorm/moving_variance/Read/ReadVariableOpReadVariableOp B2_CF2_BatchNorm/moving_variance*
_output_shapes
:*
dtype0
�
B2_CF2_Conv2D/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape:*%
shared_nameB2_CF2_Conv2D/kernel
�
(B2_CF2_Conv2D/kernel/Read/ReadVariableOpReadVariableOpB2_CF2_Conv2D/kernel*&
_output_shapes
:*
dtype0
�
T2_CF_BatchNorm/betaVarHandleOp*
_output_shapes
: *
dtype0*
shape: *%
shared_nameT2_CF_BatchNorm/beta
y
(T2_CF_BatchNorm/beta/Read/ReadVariableOpReadVariableOpT2_CF_BatchNorm/beta*
_output_shapes
: *
dtype0
�
T2_CF_BatchNorm/moving_meanVarHandleOp*
_output_shapes
: *
dtype0*
shape: *,
shared_nameT2_CF_BatchNorm/moving_mean
�
/T2_CF_BatchNorm/moving_mean/Read/ReadVariableOpReadVariableOpT2_CF_BatchNorm/moving_mean*
_output_shapes
: *
dtype0
�
T2_CF_BatchNorm/moving_varianceVarHandleOp*
_output_shapes
: *
dtype0*
shape: *0
shared_name!T2_CF_BatchNorm/moving_variance
�
3T2_CF_BatchNorm/moving_variance/Read/ReadVariableOpReadVariableOpT2_CF_BatchNorm/moving_variance*
_output_shapes
: *
dtype0
�
T2_CF_Conv2D/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape:  *$
shared_nameT2_CF_Conv2D/kernel
�
'T2_CF_Conv2D/kernel/Read/ReadVariableOpReadVariableOpT2_CF_Conv2D/kernel*&
_output_shapes
:  *
dtype0
�
B3_CF1_BatchNorm/betaVarHandleOp*
_output_shapes
: *
dtype0*
shape: *&
shared_nameB3_CF1_BatchNorm/beta
{
)B3_CF1_BatchNorm/beta/Read/ReadVariableOpReadVariableOpB3_CF1_BatchNorm/beta*
_output_shapes
: *
dtype0
�
B3_CF1_BatchNorm/moving_meanVarHandleOp*
_output_shapes
: *
dtype0*
shape: *-
shared_nameB3_CF1_BatchNorm/moving_mean
�
0B3_CF1_BatchNorm/moving_mean/Read/ReadVariableOpReadVariableOpB3_CF1_BatchNorm/moving_mean*
_output_shapes
: *
dtype0
�
 B3_CF1_BatchNorm/moving_varianceVarHandleOp*
_output_shapes
: *
dtype0*
shape: *1
shared_name" B3_CF1_BatchNorm/moving_variance
�
4B3_CF1_BatchNorm/moving_variance/Read/ReadVariableOpReadVariableOp B3_CF1_BatchNorm/moving_variance*
_output_shapes
: *
dtype0
�
B3_CF1_Conv2D/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape: *%
shared_nameB3_CF1_Conv2D/kernel
�
(B3_CF1_Conv2D/kernel/Read/ReadVariableOpReadVariableOpB3_CF1_Conv2D/kernel*&
_output_shapes
: *
dtype0
�
B3_CF2_BatchNorm/betaVarHandleOp*
_output_shapes
: *
dtype0*
shape:*&
shared_nameB3_CF2_BatchNorm/beta
{
)B3_CF2_BatchNorm/beta/Read/ReadVariableOpReadVariableOpB3_CF2_BatchNorm/beta*
_output_shapes
:*
dtype0
�
B3_CF2_BatchNorm/moving_meanVarHandleOp*
_output_shapes
: *
dtype0*
shape:*-
shared_nameB3_CF2_BatchNorm/moving_mean
�
0B3_CF2_BatchNorm/moving_mean/Read/ReadVariableOpReadVariableOpB3_CF2_BatchNorm/moving_mean*
_output_shapes
:*
dtype0
�
 B3_CF2_BatchNorm/moving_varianceVarHandleOp*
_output_shapes
: *
dtype0*
shape:*1
shared_name" B3_CF2_BatchNorm/moving_variance
�
4B3_CF2_BatchNorm/moving_variance/Read/ReadVariableOpReadVariableOp B3_CF2_BatchNorm/moving_variance*
_output_shapes
:*
dtype0
�
B3_CF2_Conv2D/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape:*%
shared_nameB3_CF2_Conv2D/kernel
�
(B3_CF2_Conv2D/kernel/Read/ReadVariableOpReadVariableOpB3_CF2_Conv2D/kernel*&
_output_shapes
:*
dtype0
�
T3_CF_BatchNorm/betaVarHandleOp*
_output_shapes
: *
dtype0*
shape:(*%
shared_nameT3_CF_BatchNorm/beta
y
(T3_CF_BatchNorm/beta/Read/ReadVariableOpReadVariableOpT3_CF_BatchNorm/beta*
_output_shapes
:(*
dtype0
�
T3_CF_BatchNorm/moving_meanVarHandleOp*
_output_shapes
: *
dtype0*
shape:(*,
shared_nameT3_CF_BatchNorm/moving_mean
�
/T3_CF_BatchNorm/moving_mean/Read/ReadVariableOpReadVariableOpT3_CF_BatchNorm/moving_mean*
_output_shapes
:(*
dtype0
�
T3_CF_BatchNorm/moving_varianceVarHandleOp*
_output_shapes
: *
dtype0*
shape:(*0
shared_name!T3_CF_BatchNorm/moving_variance
�
3T3_CF_BatchNorm/moving_variance/Read/ReadVariableOpReadVariableOpT3_CF_BatchNorm/moving_variance*
_output_shapes
:(*
dtype0
�
T3_CF_Conv2D/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape:((*$
shared_nameT3_CF_Conv2D/kernel
�
'T3_CF_Conv2D/kernel/Read/ReadVariableOpReadVariableOpT3_CF_Conv2D/kernel*&
_output_shapes
:((*
dtype0
�
B4_CF1_BatchNorm/betaVarHandleOp*
_output_shapes
: *
dtype0*
shape:(*&
shared_nameB4_CF1_BatchNorm/beta
{
)B4_CF1_BatchNorm/beta/Read/ReadVariableOpReadVariableOpB4_CF1_BatchNorm/beta*
_output_shapes
:(*
dtype0
�
B4_CF1_BatchNorm/moving_meanVarHandleOp*
_output_shapes
: *
dtype0*
shape:(*-
shared_nameB4_CF1_BatchNorm/moving_mean
�
0B4_CF1_BatchNorm/moving_mean/Read/ReadVariableOpReadVariableOpB4_CF1_BatchNorm/moving_mean*
_output_shapes
:(*
dtype0
�
 B4_CF1_BatchNorm/moving_varianceVarHandleOp*
_output_shapes
: *
dtype0*
shape:(*1
shared_name" B4_CF1_BatchNorm/moving_variance
�
4B4_CF1_BatchNorm/moving_variance/Read/ReadVariableOpReadVariableOp B4_CF1_BatchNorm/moving_variance*
_output_shapes
:(*
dtype0
�
B4_CF1_Conv2D/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape:(*%
shared_nameB4_CF1_Conv2D/kernel
�
(B4_CF1_Conv2D/kernel/Read/ReadVariableOpReadVariableOpB4_CF1_Conv2D/kernel*&
_output_shapes
:(*
dtype0
�
batch_normalization/betaVarHandleOp*
_output_shapes
: *
dtype0*
shape:,*)
shared_namebatch_normalization/beta
�
,batch_normalization/beta/Read/ReadVariableOpReadVariableOpbatch_normalization/beta*
_output_shapes
:,*
dtype0
�
batch_normalization/moving_meanVarHandleOp*
_output_shapes
: *
dtype0*
shape:,*0
shared_name!batch_normalization/moving_mean
�
3batch_normalization/moving_mean/Read/ReadVariableOpReadVariableOpbatch_normalization/moving_mean*
_output_shapes
:,*
dtype0
�
#batch_normalization/moving_varianceVarHandleOp*
_output_shapes
: *
dtype0*
shape:,*4
shared_name%#batch_normalization/moving_variance
�
7batch_normalization/moving_variance/Read/ReadVariableOpReadVariableOp#batch_normalization/moving_variance*
_output_shapes
:,*
dtype0
t
FC-D1/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:,*
shared_nameFC-D1/kernel
m
 FC-D1/kernel/Read/ReadVariableOpReadVariableOpFC-D1/kernel*
_output_shapes

:,*
dtype0
z
BatchNorm-D1/betaVarHandleOp*
_output_shapes
: *
dtype0*
shape:*"
shared_nameBatchNorm-D1/beta
s
%BatchNorm-D1/beta/Read/ReadVariableOpReadVariableOpBatchNorm-D1/beta*
_output_shapes
:*
dtype0
�
BatchNorm-D1/moving_meanVarHandleOp*
_output_shapes
: *
dtype0*
shape:*)
shared_nameBatchNorm-D1/moving_mean
�
,BatchNorm-D1/moving_mean/Read/ReadVariableOpReadVariableOpBatchNorm-D1/moving_mean*
_output_shapes
:*
dtype0
�
BatchNorm-D1/moving_varianceVarHandleOp*
_output_shapes
: *
dtype0*
shape:*-
shared_nameBatchNorm-D1/moving_variance
�
0BatchNorm-D1/moving_variance/Read/ReadVariableOpReadVariableOpBatchNorm-D1/moving_variance*
_output_shapes
:*
dtype0
v
Logits/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:*
shared_nameLogits/kernel
o
!Logits/kernel/Read/ReadVariableOpReadVariableOpLogits/kernel*
_output_shapes

:*
dtype0
n
Logits/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:*
shared_nameLogits/bias
g
Logits/bias/Read/ReadVariableOpReadVariableOpLogits/bias*
_output_shapes
:*
dtype0
R
ConstConst*
_output_shapes
:*
dtype0*
valueB*  �?
T
Const_1Const*
_output_shapes
:*
dtype0*
valueB*  �?
T
Const_2Const*
_output_shapes
:*
dtype0*
valueB*  �?
T
Const_3Const*
_output_shapes
:*
dtype0*
valueB*  �?
T
Const_4Const*
_output_shapes
:*
dtype0*
valueB*  �?
T
Const_5Const*
_output_shapes
: *
dtype0*
valueB *  �?
T
Const_6Const*
_output_shapes
: *
dtype0*
valueB *  �?
T
Const_7Const*
_output_shapes
:*
dtype0*
valueB*  �?
T
Const_8Const*
_output_shapes
:(*
dtype0*
valueB(*  �?
T
Const_9Const*
_output_shapes
:(*
dtype0*
valueB(*  �?
U
Const_10Const*
_output_shapes
:,*
dtype0*
valueB,*  �?

NoOpNoOp
��
Const_11Const"/device:CPU:0*
_output_shapes
: *
dtype0*��
value��B�� B��

	model

signatures
�
layer-0
layer-1
layer-2
layer_with_weights-0
layer-3
layer_with_weights-1
layer-4
layer-5
	layer_with_weights-2
	layer-6

layer-7
layer_with_weights-3
layer-8
layer-9
layer_with_weights-4
layer-10
layer-11
layer-12
layer_with_weights-5
layer-13
layer-14
layer_with_weights-6
layer-15
layer-16
layer-17
layer-18
layer_with_weights-7
layer-19
layer-20
layer_with_weights-8
layer-21
layer-22
layer_with_weights-9
layer-23
layer-24
layer_with_weights-10
layer-25
layer-26
layer-27
layer_with_weights-11
layer-28
 layer-29
!layer_with_weights-12
!layer-30
"layer-31
#layer-32
$layer-33
%layer_with_weights-13
%layer-34
&layer-35
'layer_with_weights-14
'layer-36
(layer-37
)layer_with_weights-15
)layer-38
*layer-39
+layer_with_weights-16
+layer-40
,layer-41
-layer-42
.layer_with_weights-17
.layer-43
/layer-44
0layer_with_weights-18
0layer-45
1layer-46
2layer-47
3layer-48
4layer_with_weights-19
4layer-49
5layer-50
6layer_with_weights-20
6layer-51
7layer-52
8layer-53
9layer_with_weights-21
9layer-54
:layer-55
;layer-56
<layer_with_weights-22
<layer-57
=layer_with_weights-23
=layer-58
>layer_with_weights-24
>layer-59
?	variables
@trainable_variables
Aregularization_losses
B	keras_api
 
 

C	keras_api
R
D	variables
Etrainable_variables
Fregularization_losses
G	keras_api
^

Hkernel
I	variables
Jtrainable_variables
Kregularization_losses
L	keras_api
�
Maxis
Nbeta
Omoving_mean
Pmoving_variance
Q	variables
Rtrainable_variables
Sregularization_losses
T	keras_api
R
U	variables
Vtrainable_variables
Wregularization_losses
X	keras_api
^

Ykernel
Z	variables
[trainable_variables
\regularization_losses
]	keras_api
R
^	variables
_trainable_variables
`regularization_losses
a	keras_api
�
baxis
cbeta
dmoving_mean
emoving_variance
f	variables
gtrainable_variables
hregularization_losses
i	keras_api
R
j	variables
ktrainable_variables
lregularization_losses
m	keras_api
^

nkernel
o	variables
ptrainable_variables
qregularization_losses
r	keras_api
R
s	variables
ttrainable_variables
uregularization_losses
v	keras_api
R
w	variables
xtrainable_variables
yregularization_losses
z	keras_api
�
{axis
|beta
}moving_mean
~moving_variance
	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
c
�kernel
�	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api

�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�
	�axis
	�beta
�moving_mean
�moving_variance
�	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
c
�kernel
�	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�
	�axis
	�beta
�moving_mean
�moving_variance
�	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
c
�kernel
�	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�
	�axis
	�beta
�moving_mean
�moving_variance
�	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
c
�kernel
�	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api

�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�
	�axis
	�beta
�moving_mean
�moving_variance
�	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
c
�kernel
�	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�
	�axis
	�beta
�moving_mean
�moving_variance
�	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
c
�kernel
�	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�
	�axis
	�beta
�moving_mean
�moving_variance
�	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
c
�kernel
�	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api

�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�
	�axis
	�beta
�moving_mean
�moving_variance
�	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
c
�kernel
�	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�
	�axis
	�beta
�moving_mean
�moving_variance
�	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
V
�	variables
�trainable_variables
�regularization_losses
�	keras_api
c
�kernel
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�
	�axis
	�beta
�moving_mean
�moving_variance
�	variables
�trainable_variables
�regularization_losses
�	keras_api
n
�kernel
	�bias
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�
H0
N1
O2
P3
Y4
c5
d6
e7
n8
|9
}10
~11
�12
�13
�14
�15
�16
�17
�18
�19
�20
�21
�22
�23
�24
�25
�26
�27
�28
�29
�30
�31
�32
�33
�34
�35
�36
�37
�38
�39
�40
�41
�42
�43
�44
�45
�46
�47
�48
�49
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
?	variables
@trainable_variables
Aregularization_losses
 
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
D	variables
Etrainable_variables
Fregularization_losses
a_
VARIABLE_VALUEPre_Conv/kernel<model/layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUE

H0
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
I	variables
Jtrainable_variables
Kregularization_losses
 
ec
VARIABLE_VALUEB1_CF1_BatchNorm/beta:model/layer_with_weights-1/beta/.ATTRIBUTES/VARIABLE_VALUE
sq
VARIABLE_VALUEB1_CF1_BatchNorm/moving_meanAmodel/layer_with_weights-1/moving_mean/.ATTRIBUTES/VARIABLE_VALUE
{y
VARIABLE_VALUE B1_CF1_BatchNorm/moving_varianceEmodel/layer_with_weights-1/moving_variance/.ATTRIBUTES/VARIABLE_VALUE

N0
O1
P2
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
Q	variables
Rtrainable_variables
Sregularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
U	variables
Vtrainable_variables
Wregularization_losses
fd
VARIABLE_VALUEB1_CF1_Conv2D/kernel<model/layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUE

Y0
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
Z	variables
[trainable_variables
\regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
^	variables
_trainable_variables
`regularization_losses
 
ec
VARIABLE_VALUEB1_CF2_BatchNorm/beta:model/layer_with_weights-3/beta/.ATTRIBUTES/VARIABLE_VALUE
sq
VARIABLE_VALUEB1_CF2_BatchNorm/moving_meanAmodel/layer_with_weights-3/moving_mean/.ATTRIBUTES/VARIABLE_VALUE
{y
VARIABLE_VALUE B1_CF2_BatchNorm/moving_varianceEmodel/layer_with_weights-3/moving_variance/.ATTRIBUTES/VARIABLE_VALUE

c0
d1
e2
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
f	variables
gtrainable_variables
hregularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
j	variables
ktrainable_variables
lregularization_losses
fd
VARIABLE_VALUEB1_CF2_Conv2D/kernel<model/layer_with_weights-4/kernel/.ATTRIBUTES/VARIABLE_VALUE

n0
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
o	variables
ptrainable_variables
qregularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
s	variables
ttrainable_variables
uregularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
w	variables
xtrainable_variables
yregularization_losses
 
db
VARIABLE_VALUET1_CF_BatchNorm/beta:model/layer_with_weights-5/beta/.ATTRIBUTES/VARIABLE_VALUE
rp
VARIABLE_VALUET1_CF_BatchNorm/moving_meanAmodel/layer_with_weights-5/moving_mean/.ATTRIBUTES/VARIABLE_VALUE
zx
VARIABLE_VALUET1_CF_BatchNorm/moving_varianceEmodel/layer_with_weights-5/moving_variance/.ATTRIBUTES/VARIABLE_VALUE

|0
}1
~2
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
ec
VARIABLE_VALUET1_CF_Conv2D/kernel<model/layer_with_weights-6/kernel/.ATTRIBUTES/VARIABLE_VALUE

�0
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
ec
VARIABLE_VALUEB2_CF1_BatchNorm/beta:model/layer_with_weights-7/beta/.ATTRIBUTES/VARIABLE_VALUE
sq
VARIABLE_VALUEB2_CF1_BatchNorm/moving_meanAmodel/layer_with_weights-7/moving_mean/.ATTRIBUTES/VARIABLE_VALUE
{y
VARIABLE_VALUE B2_CF1_BatchNorm/moving_varianceEmodel/layer_with_weights-7/moving_variance/.ATTRIBUTES/VARIABLE_VALUE

�0
�1
�2
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
fd
VARIABLE_VALUEB2_CF1_Conv2D/kernel<model/layer_with_weights-8/kernel/.ATTRIBUTES/VARIABLE_VALUE

�0
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
ec
VARIABLE_VALUEB2_CF2_BatchNorm/beta:model/layer_with_weights-9/beta/.ATTRIBUTES/VARIABLE_VALUE
sq
VARIABLE_VALUEB2_CF2_BatchNorm/moving_meanAmodel/layer_with_weights-9/moving_mean/.ATTRIBUTES/VARIABLE_VALUE
{y
VARIABLE_VALUE B2_CF2_BatchNorm/moving_varianceEmodel/layer_with_weights-9/moving_variance/.ATTRIBUTES/VARIABLE_VALUE

�0
�1
�2
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
ge
VARIABLE_VALUEB2_CF2_Conv2D/kernel=model/layer_with_weights-10/kernel/.ATTRIBUTES/VARIABLE_VALUE

�0
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
ec
VARIABLE_VALUET2_CF_BatchNorm/beta;model/layer_with_weights-11/beta/.ATTRIBUTES/VARIABLE_VALUE
sq
VARIABLE_VALUET2_CF_BatchNorm/moving_meanBmodel/layer_with_weights-11/moving_mean/.ATTRIBUTES/VARIABLE_VALUE
{y
VARIABLE_VALUET2_CF_BatchNorm/moving_varianceFmodel/layer_with_weights-11/moving_variance/.ATTRIBUTES/VARIABLE_VALUE

�0
�1
�2
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
fd
VARIABLE_VALUET2_CF_Conv2D/kernel=model/layer_with_weights-12/kernel/.ATTRIBUTES/VARIABLE_VALUE

�0
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
fd
VARIABLE_VALUEB3_CF1_BatchNorm/beta;model/layer_with_weights-13/beta/.ATTRIBUTES/VARIABLE_VALUE
tr
VARIABLE_VALUEB3_CF1_BatchNorm/moving_meanBmodel/layer_with_weights-13/moving_mean/.ATTRIBUTES/VARIABLE_VALUE
|z
VARIABLE_VALUE B3_CF1_BatchNorm/moving_varianceFmodel/layer_with_weights-13/moving_variance/.ATTRIBUTES/VARIABLE_VALUE

�0
�1
�2
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
ge
VARIABLE_VALUEB3_CF1_Conv2D/kernel=model/layer_with_weights-14/kernel/.ATTRIBUTES/VARIABLE_VALUE

�0
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
fd
VARIABLE_VALUEB3_CF2_BatchNorm/beta;model/layer_with_weights-15/beta/.ATTRIBUTES/VARIABLE_VALUE
tr
VARIABLE_VALUEB3_CF2_BatchNorm/moving_meanBmodel/layer_with_weights-15/moving_mean/.ATTRIBUTES/VARIABLE_VALUE
|z
VARIABLE_VALUE B3_CF2_BatchNorm/moving_varianceFmodel/layer_with_weights-15/moving_variance/.ATTRIBUTES/VARIABLE_VALUE

�0
�1
�2
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
ge
VARIABLE_VALUEB3_CF2_Conv2D/kernel=model/layer_with_weights-16/kernel/.ATTRIBUTES/VARIABLE_VALUE

�0
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
ec
VARIABLE_VALUET3_CF_BatchNorm/beta;model/layer_with_weights-17/beta/.ATTRIBUTES/VARIABLE_VALUE
sq
VARIABLE_VALUET3_CF_BatchNorm/moving_meanBmodel/layer_with_weights-17/moving_mean/.ATTRIBUTES/VARIABLE_VALUE
{y
VARIABLE_VALUET3_CF_BatchNorm/moving_varianceFmodel/layer_with_weights-17/moving_variance/.ATTRIBUTES/VARIABLE_VALUE

�0
�1
�2
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
fd
VARIABLE_VALUET3_CF_Conv2D/kernel=model/layer_with_weights-18/kernel/.ATTRIBUTES/VARIABLE_VALUE

�0
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
fd
VARIABLE_VALUEB4_CF1_BatchNorm/beta;model/layer_with_weights-19/beta/.ATTRIBUTES/VARIABLE_VALUE
tr
VARIABLE_VALUEB4_CF1_BatchNorm/moving_meanBmodel/layer_with_weights-19/moving_mean/.ATTRIBUTES/VARIABLE_VALUE
|z
VARIABLE_VALUE B4_CF1_BatchNorm/moving_varianceFmodel/layer_with_weights-19/moving_variance/.ATTRIBUTES/VARIABLE_VALUE

�0
�1
�2
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
ge
VARIABLE_VALUEB4_CF1_Conv2D/kernel=model/layer_with_weights-20/kernel/.ATTRIBUTES/VARIABLE_VALUE

�0
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
ig
VARIABLE_VALUEbatch_normalization/beta;model/layer_with_weights-21/beta/.ATTRIBUTES/VARIABLE_VALUE
wu
VARIABLE_VALUEbatch_normalization/moving_meanBmodel/layer_with_weights-21/moving_mean/.ATTRIBUTES/VARIABLE_VALUE
}
VARIABLE_VALUE#batch_normalization/moving_varianceFmodel/layer_with_weights-21/moving_variance/.ATTRIBUTES/VARIABLE_VALUE

�0
�1
�2
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
_]
VARIABLE_VALUEFC-D1/kernel=model/layer_with_weights-22/kernel/.ATTRIBUTES/VARIABLE_VALUE

�0
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
 
b`
VARIABLE_VALUEBatchNorm-D1/beta;model/layer_with_weights-23/beta/.ATTRIBUTES/VARIABLE_VALUE
pn
VARIABLE_VALUEBatchNorm-D1/moving_meanBmodel/layer_with_weights-23/moving_mean/.ATTRIBUTES/VARIABLE_VALUE
xv
VARIABLE_VALUEBatchNorm-D1/moving_varianceFmodel/layer_with_weights-23/moving_variance/.ATTRIBUTES/VARIABLE_VALUE

�0
�1
�2
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
`^
VARIABLE_VALUELogits/kernel=model/layer_with_weights-24/kernel/.ATTRIBUTES/VARIABLE_VALUE
\Z
VARIABLE_VALUELogits/bias;model/layer_with_weights-24/bias/.ATTRIBUTES/VARIABLE_VALUE

�0
�1
 
 
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�
H0
N1
O2
P3
Y4
c5
d6
e7
n8
|9
}10
~11
�12
�13
�14
�15
�16
�17
�18
�19
�20
�21
�22
�23
�24
�25
�26
�27
�28
�29
�30
�31
�32
�33
�34
�35
�36
�37
�38
�39
�40
�41
�42
�43
�44
�45
�46
�47
�48
�49
�
0
1
2
3
4
5
	6

7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
 29
!30
"31
#32
$33
%34
&35
'36
(37
)38
*39
+40
,41
-42
.43
/44
045
146
247
348
449
550
651
752
853
954
:55
;56
<57
=58
>59
 
 
 
 
 
 
 
 

H0
 
 
 
 

N0
O1
P2
 
 
 
 
 
 
 
 
 

Y0
 
 
 
 
 
 
 
 
 

c0
d1
e2
 
 
 
 
 
 
 
 
 

n0
 
 
 
 
 
 
 
 
 
 
 
 
 
 

|0
}1
~2
 
 
 
 
 
 
 
 
 

�0
 
 
 
 
 
 
 
 
 
 
 
 
 
 

�0
�1
�2
 
 
 
 
 
 
 
 
 

�0
 
 
 
 
 
 
 
 
 

�0
�1
�2
 
 
 
 
 
 
 
 
 

�0
 
 
 
 
 
 
 
 
 
 
 
 
 
 

�0
�1
�2
 
 
 
 
 
 
 
 
 

�0
 
 
 
 
 
 
 
 
 
 
 
 
 
 

�0
�1
�2
 
 
 
 
 
 
 
 
 

�0
 
 
 
 
 
 
 
 
 

�0
�1
�2
 
 
 
 
 
 
 
 
 

�0
 
 
 
 
 
 
 
 
 
 
 
 
 
 

�0
�1
�2
 
 
 
 
 
 
 
 
 

�0
 
 
 
 
 
 
 
 
 
 
 
 
 
 

�0
�1
�2
 
 
 
 
 
 
 
 
 

�0
 
 
 
 
 
 
 
 
 
 
 
 
 
 

�0
�1
�2
 
 
 
 
 
 
 
 
 
 
 
 
 
 

�0
 
 
 
 

�0
�1
�2
 
 
 
 

�0
�1
 
 
 
 
w
basic_inputsPlaceholder*+
_output_shapes
:���������-C*
dtype0* 
shape:���������-C
�
StatefulPartitionedCallStatefulPartitionedCallbasic_inputsPre_Conv/kernelConstB1_CF1_BatchNorm/betaB1_CF1_BatchNorm/moving_mean B1_CF1_BatchNorm/moving_varianceB1_CF1_Conv2D/kernelConst_1B1_CF2_BatchNorm/betaB1_CF2_BatchNorm/moving_mean B1_CF2_BatchNorm/moving_varianceB1_CF2_Conv2D/kernelConst_2T1_CF_BatchNorm/betaT1_CF_BatchNorm/moving_meanT1_CF_BatchNorm/moving_varianceT1_CF_Conv2D/kernelConst_3B2_CF1_BatchNorm/betaB2_CF1_BatchNorm/moving_mean B2_CF1_BatchNorm/moving_varianceB2_CF1_Conv2D/kernelConst_4B2_CF2_BatchNorm/betaB2_CF2_BatchNorm/moving_mean B2_CF2_BatchNorm/moving_varianceB2_CF2_Conv2D/kernelConst_5T2_CF_BatchNorm/betaT2_CF_BatchNorm/moving_meanT2_CF_BatchNorm/moving_varianceT2_CF_Conv2D/kernelConst_6B3_CF1_BatchNorm/betaB3_CF1_BatchNorm/moving_mean B3_CF1_BatchNorm/moving_varianceB3_CF1_Conv2D/kernelConst_7B3_CF2_BatchNorm/betaB3_CF2_BatchNorm/moving_mean B3_CF2_BatchNorm/moving_varianceB3_CF2_Conv2D/kernelConst_8T3_CF_BatchNorm/betaT3_CF_BatchNorm/moving_meanT3_CF_BatchNorm/moving_varianceT3_CF_Conv2D/kernelConst_9B4_CF1_BatchNorm/betaB4_CF1_BatchNorm/moving_mean B4_CF1_BatchNorm/moving_varianceB4_CF1_Conv2D/kernelConst_10batch_normalization/betabatch_normalization/moving_mean#batch_normalization/moving_varianceFC-D1/kernelBatchNorm-D1/moving_varianceBatchNorm-D1/moving_meanBatchNorm-D1/betaLogits/kernelLogits/bias*I
TinB
@2>*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*T
_read_only_resource_inputs6
42	
!"#$&'()+,-.012356789:;<=*-
config_proto

CPU

GPU 2J 8� *+
f&R$
"__inference_signature_wrapper_1133

with_transformation_inputsPlaceholder*(
_output_shapes
:����������*
dtype0*
shape:����������
�
StatefulPartitionedCall_1StatefulPartitionedCallwith_transformation_inputsPre_Conv/kernelConstB1_CF1_BatchNorm/betaB1_CF1_BatchNorm/moving_mean B1_CF1_BatchNorm/moving_varianceB1_CF1_Conv2D/kernelConst_1B1_CF2_BatchNorm/betaB1_CF2_BatchNorm/moving_mean B1_CF2_BatchNorm/moving_varianceB1_CF2_Conv2D/kernelConst_2T1_CF_BatchNorm/betaT1_CF_BatchNorm/moving_meanT1_CF_BatchNorm/moving_varianceT1_CF_Conv2D/kernelConst_3B2_CF1_BatchNorm/betaB2_CF1_BatchNorm/moving_mean B2_CF1_BatchNorm/moving_varianceB2_CF1_Conv2D/kernelConst_4B2_CF2_BatchNorm/betaB2_CF2_BatchNorm/moving_mean B2_CF2_BatchNorm/moving_varianceB2_CF2_Conv2D/kernelConst_5T2_CF_BatchNorm/betaT2_CF_BatchNorm/moving_meanT2_CF_BatchNorm/moving_varianceT2_CF_Conv2D/kernelConst_6B3_CF1_BatchNorm/betaB3_CF1_BatchNorm/moving_mean B3_CF1_BatchNorm/moving_varianceB3_CF1_Conv2D/kernelConst_7B3_CF2_BatchNorm/betaB3_CF2_BatchNorm/moving_mean B3_CF2_BatchNorm/moving_varianceB3_CF2_Conv2D/kernelConst_8T3_CF_BatchNorm/betaT3_CF_BatchNorm/moving_meanT3_CF_BatchNorm/moving_varianceT3_CF_Conv2D/kernelConst_9B4_CF1_BatchNorm/betaB4_CF1_BatchNorm/moving_mean B4_CF1_BatchNorm/moving_varianceB4_CF1_Conv2D/kernelConst_10batch_normalization/betabatch_normalization/moving_mean#batch_normalization/moving_varianceFC-D1/kernelBatchNorm-D1/moving_varianceBatchNorm-D1/moving_meanBatchNorm-D1/betaLogits/kernelLogits/bias*I
TinB
@2>*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*T
_read_only_resource_inputs6
42	
!"#$&'()+,-.012356789:;<=*-
config_proto

CPU

GPU 2J 8� *+
f&R$
"__inference_signature_wrapper_1655
O
saver_filenamePlaceholder*
_output_shapes
: *
dtype0*
shape: 
�
StatefulPartitionedCall_2StatefulPartitionedCallsaver_filename#Pre_Conv/kernel/Read/ReadVariableOp)B1_CF1_BatchNorm/beta/Read/ReadVariableOp0B1_CF1_BatchNorm/moving_mean/Read/ReadVariableOp4B1_CF1_BatchNorm/moving_variance/Read/ReadVariableOp(B1_CF1_Conv2D/kernel/Read/ReadVariableOp)B1_CF2_BatchNorm/beta/Read/ReadVariableOp0B1_CF2_BatchNorm/moving_mean/Read/ReadVariableOp4B1_CF2_BatchNorm/moving_variance/Read/ReadVariableOp(B1_CF2_Conv2D/kernel/Read/ReadVariableOp(T1_CF_BatchNorm/beta/Read/ReadVariableOp/T1_CF_BatchNorm/moving_mean/Read/ReadVariableOp3T1_CF_BatchNorm/moving_variance/Read/ReadVariableOp'T1_CF_Conv2D/kernel/Read/ReadVariableOp)B2_CF1_BatchNorm/beta/Read/ReadVariableOp0B2_CF1_BatchNorm/moving_mean/Read/ReadVariableOp4B2_CF1_BatchNorm/moving_variance/Read/ReadVariableOp(B2_CF1_Conv2D/kernel/Read/ReadVariableOp)B2_CF2_BatchNorm/beta/Read/ReadVariableOp0B2_CF2_BatchNorm/moving_mean/Read/ReadVariableOp4B2_CF2_BatchNorm/moving_variance/Read/ReadVariableOp(B2_CF2_Conv2D/kernel/Read/ReadVariableOp(T2_CF_BatchNorm/beta/Read/ReadVariableOp/T2_CF_BatchNorm/moving_mean/Read/ReadVariableOp3T2_CF_BatchNorm/moving_variance/Read/ReadVariableOp'T2_CF_Conv2D/kernel/Read/ReadVariableOp)B3_CF1_BatchNorm/beta/Read/ReadVariableOp0B3_CF1_BatchNorm/moving_mean/Read/ReadVariableOp4B3_CF1_BatchNorm/moving_variance/Read/ReadVariableOp(B3_CF1_Conv2D/kernel/Read/ReadVariableOp)B3_CF2_BatchNorm/beta/Read/ReadVariableOp0B3_CF2_BatchNorm/moving_mean/Read/ReadVariableOp4B3_CF2_BatchNorm/moving_variance/Read/ReadVariableOp(B3_CF2_Conv2D/kernel/Read/ReadVariableOp(T3_CF_BatchNorm/beta/Read/ReadVariableOp/T3_CF_BatchNorm/moving_mean/Read/ReadVariableOp3T3_CF_BatchNorm/moving_variance/Read/ReadVariableOp'T3_CF_Conv2D/kernel/Read/ReadVariableOp)B4_CF1_BatchNorm/beta/Read/ReadVariableOp0B4_CF1_BatchNorm/moving_mean/Read/ReadVariableOp4B4_CF1_BatchNorm/moving_variance/Read/ReadVariableOp(B4_CF1_Conv2D/kernel/Read/ReadVariableOp,batch_normalization/beta/Read/ReadVariableOp3batch_normalization/moving_mean/Read/ReadVariableOp7batch_normalization/moving_variance/Read/ReadVariableOp FC-D1/kernel/Read/ReadVariableOp%BatchNorm-D1/beta/Read/ReadVariableOp,BatchNorm-D1/moving_mean/Read/ReadVariableOp0BatchNorm-D1/moving_variance/Read/ReadVariableOp!Logits/kernel/Read/ReadVariableOpLogits/bias/Read/ReadVariableOpConst_11*?
Tin8
624*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *&
f!R
__inference__traced_save_8483
�
StatefulPartitionedCall_3StatefulPartitionedCallsaver_filenamePre_Conv/kernelB1_CF1_BatchNorm/betaB1_CF1_BatchNorm/moving_mean B1_CF1_BatchNorm/moving_varianceB1_CF1_Conv2D/kernelB1_CF2_BatchNorm/betaB1_CF2_BatchNorm/moving_mean B1_CF2_BatchNorm/moving_varianceB1_CF2_Conv2D/kernelT1_CF_BatchNorm/betaT1_CF_BatchNorm/moving_meanT1_CF_BatchNorm/moving_varianceT1_CF_Conv2D/kernelB2_CF1_BatchNorm/betaB2_CF1_BatchNorm/moving_mean B2_CF1_BatchNorm/moving_varianceB2_CF1_Conv2D/kernelB2_CF2_BatchNorm/betaB2_CF2_BatchNorm/moving_mean B2_CF2_BatchNorm/moving_varianceB2_CF2_Conv2D/kernelT2_CF_BatchNorm/betaT2_CF_BatchNorm/moving_meanT2_CF_BatchNorm/moving_varianceT2_CF_Conv2D/kernelB3_CF1_BatchNorm/betaB3_CF1_BatchNorm/moving_mean B3_CF1_BatchNorm/moving_varianceB3_CF1_Conv2D/kernelB3_CF2_BatchNorm/betaB3_CF2_BatchNorm/moving_mean B3_CF2_BatchNorm/moving_varianceB3_CF2_Conv2D/kernelT3_CF_BatchNorm/betaT3_CF_BatchNorm/moving_meanT3_CF_BatchNorm/moving_varianceT3_CF_Conv2D/kernelB4_CF1_BatchNorm/betaB4_CF1_BatchNorm/moving_mean B4_CF1_BatchNorm/moving_varianceB4_CF1_Conv2D/kernelbatch_normalization/betabatch_normalization/moving_mean#batch_normalization/moving_varianceFC-D1/kernelBatchNorm-D1/betaBatchNorm-D1/moving_meanBatchNorm-D1/moving_varianceLogits/kernelLogits/bias*>
Tin7
523*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *)
f$R"
 __inference__traced_restore_8643��.
�
e
,__inference_T3_CF_Dropout_layer_call_fn_7834

inputs
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_T3_CF_Dropout_layer_call_and_return_conditional_losses_3682w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������(`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������(22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs
�
�
2__inference_batch_normalization_layer_call_fn_8107

inputs
unknown
	unknown_0:,
	unknown_1:,
	unknown_2:,
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������,*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *V
fQRO
M__inference_batch_normalization_layer_call_and_return_conditional_losses_3559w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������,`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������,:,: : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������,
 
_user_specified_nameinputs: 

_output_shapes
:,
�
a
E__inference_B1_CF1_ReLu_layer_call_and_return_conditional_losses_6357

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:���������-Cb
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�	
�
/__inference_B4_CF1_BatchNorm_layer_call_fn_7884

inputs
unknown
	unknown_0:(
	unknown_1:(
	unknown_2:(
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+���������������������������(*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_2520�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������(`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������(:(: : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+���������������������������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�
�
.__inference_T3_CF_BatchNorm_layer_call_fn_7732

inputs
unknown
	unknown_0:(
	unknown_1:(
	unknown_2:(
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_3731w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������(`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������(:(: : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�
�
+__inference_BatchNorm-D1_layer_call_fn_8243

inputs
unknown:
	unknown_0:
	unknown_1:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_BatchNorm-D1_layer_call_and_return_conditional_losses_2685o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*,
_input_shapes
:���������: : : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_2124

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
I
-__inference_B3_CF1_Dropout_layer_call_fn_7472

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B3_CF1_Dropout_layer_call_and_return_conditional_losses_3115h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
a
E__inference_B4_CF1_ReLu_layer_call_and_return_conditional_losses_8001

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:���������(b
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:���������("
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������(:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs
�
�
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_6687

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������-C�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������-C:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:
��
�
B__inference_DenseNet_layer_call_and_return_conditional_losses_3373

inputs'
pre_conv_2721:
b1_cf1_batchnorm_2741#
b1_cf1_batchnorm_2743:#
b1_cf1_batchnorm_2745:#
b1_cf1_batchnorm_2747:,
b1_cf1_conv2d_2765:
b1_cf2_batchnorm_2792#
b1_cf2_batchnorm_2794:#
b1_cf2_batchnorm_2796:#
b1_cf2_batchnorm_2798:,
b1_cf2_conv2d_2816:
t1_cf_batchnorm_2853"
t1_cf_batchnorm_2855:"
t1_cf_batchnorm_2857:"
t1_cf_batchnorm_2859:+
t1_cf_conv2d_2877:
b2_cf1_batchnorm_2912#
b2_cf1_batchnorm_2914:#
b2_cf1_batchnorm_2916:#
b2_cf1_batchnorm_2918:,
b2_cf1_conv2d_2936:
b2_cf2_batchnorm_2963#
b2_cf2_batchnorm_2965:#
b2_cf2_batchnorm_2967:#
b2_cf2_batchnorm_2969:,
b2_cf2_conv2d_2987:
t2_cf_batchnorm_3024"
t2_cf_batchnorm_3026: "
t2_cf_batchnorm_3028: "
t2_cf_batchnorm_3030: +
t2_cf_conv2d_3048:  
b3_cf1_batchnorm_3083#
b3_cf1_batchnorm_3085: #
b3_cf1_batchnorm_3087: #
b3_cf1_batchnorm_3089: ,
b3_cf1_conv2d_3107: 
b3_cf2_batchnorm_3134#
b3_cf2_batchnorm_3136:#
b3_cf2_batchnorm_3138:#
b3_cf2_batchnorm_3140:,
b3_cf2_conv2d_3158:
t3_cf_batchnorm_3195"
t3_cf_batchnorm_3197:("
t3_cf_batchnorm_3199:("
t3_cf_batchnorm_3201:(+
t3_cf_conv2d_3219:((
b4_cf1_batchnorm_3254#
b4_cf1_batchnorm_3256:(#
b4_cf1_batchnorm_3258:(#
b4_cf1_batchnorm_3260:(,
b4_cf1_conv2d_3278:(
batch_normalization_3314&
batch_normalization_3316:,&
batch_normalization_3318:,&
batch_normalization_3320:,

fc_d1_3345:,
batchnorm_d1_3348:
batchnorm_d1_3350:
batchnorm_d1_3352:
logits_3367:
logits_3369:
identity��(B1_CF1_BatchNorm/StatefulPartitionedCall�%B1_CF1_Conv2D/StatefulPartitionedCall�(B1_CF2_BatchNorm/StatefulPartitionedCall�%B1_CF2_Conv2D/StatefulPartitionedCall�(B2_CF1_BatchNorm/StatefulPartitionedCall�%B2_CF1_Conv2D/StatefulPartitionedCall�(B2_CF2_BatchNorm/StatefulPartitionedCall�%B2_CF2_Conv2D/StatefulPartitionedCall�(B3_CF1_BatchNorm/StatefulPartitionedCall�%B3_CF1_Conv2D/StatefulPartitionedCall�(B3_CF2_BatchNorm/StatefulPartitionedCall�%B3_CF2_Conv2D/StatefulPartitionedCall�(B4_CF1_BatchNorm/StatefulPartitionedCall�%B4_CF1_Conv2D/StatefulPartitionedCall�$BatchNorm-D1/StatefulPartitionedCall�FC-D1/StatefulPartitionedCall�Logits/StatefulPartitionedCall� Pre_Conv/StatefulPartitionedCall�'T1_CF_BatchNorm/StatefulPartitionedCall�$T1_CF_Conv2D/StatefulPartitionedCall�'T2_CF_BatchNorm/StatefulPartitionedCall�$T2_CF_Conv2D/StatefulPartitionedCall�'T3_CF_BatchNorm/StatefulPartitionedCall�$T3_CF_Conv2D/StatefulPartitionedCall�+batch_normalization/StatefulPartitionedCall_
tf.expand_dims/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B :�
tf.expand_dims/ExpandDims
ExpandDimsinputs&tf.expand_dims/ExpandDims/dim:output:0*
T0*/
_output_shapes
:���������-C�
rescaling/PartitionedCallPartitionedCall"tf.expand_dims/ExpandDims:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_rescaling_layer_call_and_return_conditional_losses_2711�
 Pre_Conv/StatefulPartitionedCallStatefulPartitionedCall"rescaling/PartitionedCall:output:0pre_conv_2721*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *K
fFRD
B__inference_Pre_Conv_layer_call_and_return_conditional_losses_2720�
(B1_CF1_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall)Pre_Conv/StatefulPartitionedCall:output:0b1_cf1_batchnorm_2741b1_cf1_batchnorm_2743b1_cf1_batchnorm_2745b1_cf1_batchnorm_2747*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_2740�
B1_CF1_ReLu/PartitionedCallPartitionedCall1B1_CF1_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B1_CF1_ReLu_layer_call_and_return_conditional_losses_2755�
%B1_CF1_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B1_CF1_ReLu/PartitionedCall:output:0b1_cf1_conv2d_2765*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B1_CF1_Conv2D_layer_call_and_return_conditional_losses_2764�
B1_CF1_Dropout/PartitionedCallPartitionedCall.B1_CF1_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B1_CF1_Dropout_layer_call_and_return_conditional_losses_2773�
(B1_CF2_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall'B1_CF1_Dropout/PartitionedCall:output:0b1_cf2_batchnorm_2792b1_cf2_batchnorm_2794b1_cf2_batchnorm_2796b1_cf2_batchnorm_2798*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_2791�
B1_CF2_ReLu/PartitionedCallPartitionedCall1B1_CF2_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B1_CF2_ReLu_layer_call_and_return_conditional_losses_2806�
%B1_CF2_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B1_CF2_ReLu/PartitionedCall:output:0b1_cf2_conv2d_2816*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B1_CF2_Conv2D_layer_call_and_return_conditional_losses_2815�
B1_CF2_Dropout/PartitionedCallPartitionedCall.B1_CF2_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B1_CF2_Dropout_layer_call_and_return_conditional_losses_2824�
B1_Concat/PartitionedCallPartitionedCall)Pre_Conv/StatefulPartitionedCall:output:0'B1_CF1_Dropout/PartitionedCall:output:0'B1_CF2_Dropout/PartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_B1_Concat_layer_call_and_return_conditional_losses_2834�
'T1_CF_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall"B1_Concat/PartitionedCall:output:0t1_cf_batchnorm_2853t1_cf_batchnorm_2855t1_cf_batchnorm_2857t1_cf_batchnorm_2859*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_2852�
T1_CF_ReLu/PartitionedCallPartitionedCall0T1_CF_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *M
fHRF
D__inference_T1_CF_ReLu_layer_call_and_return_conditional_losses_2867�
$T1_CF_Conv2D/StatefulPartitionedCallStatefulPartitionedCall#T1_CF_ReLu/PartitionedCall:output:0t1_cf_conv2d_2877*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_T1_CF_Conv2D_layer_call_and_return_conditional_losses_2876�
T1_CF_Dropout/PartitionedCallPartitionedCall-T1_CF_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_T1_CF_Dropout_layer_call_and_return_conditional_losses_2885�
tf.compat.v1.pad/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
tf.compat.v1.pad/PadPad&T1_CF_Dropout/PartitionedCall:output:0&tf.compat.v1.pad/Pad/paddings:output:0*
T0*/
_output_shapes
:���������-E�
T1_Pool/PartitionedCallPartitionedCalltf.compat.v1.pad/Pad:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *J
fERC
A__inference_T1_Pool_layer_call_and_return_conditional_losses_2893�
(B2_CF1_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall T1_Pool/PartitionedCall:output:0b2_cf1_batchnorm_2912b2_cf1_batchnorm_2914b2_cf1_batchnorm_2916b2_cf1_batchnorm_2918*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_2911�
B2_CF1_ReLu/PartitionedCallPartitionedCall1B2_CF1_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B2_CF1_ReLu_layer_call_and_return_conditional_losses_2926�
%B2_CF1_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B2_CF1_ReLu/PartitionedCall:output:0b2_cf1_conv2d_2936*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B2_CF1_Conv2D_layer_call_and_return_conditional_losses_2935�
B2_CF1_Dropout/PartitionedCallPartitionedCall.B2_CF1_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B2_CF1_Dropout_layer_call_and_return_conditional_losses_2944�
(B2_CF2_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall'B2_CF1_Dropout/PartitionedCall:output:0b2_cf2_batchnorm_2963b2_cf2_batchnorm_2965b2_cf2_batchnorm_2967b2_cf2_batchnorm_2969*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_2962�
B2_CF2_ReLu/PartitionedCallPartitionedCall1B2_CF2_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B2_CF2_ReLu_layer_call_and_return_conditional_losses_2977�
%B2_CF2_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B2_CF2_ReLu/PartitionedCall:output:0b2_cf2_conv2d_2987*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B2_CF2_Conv2D_layer_call_and_return_conditional_losses_2986�
B2_CF2_Dropout/PartitionedCallPartitionedCall.B2_CF2_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B2_CF2_Dropout_layer_call_and_return_conditional_losses_2995�
B2_Concat/PartitionedCallPartitionedCall T1_Pool/PartitionedCall:output:0'B2_CF1_Dropout/PartitionedCall:output:0'B2_CF2_Dropout/PartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_B2_Concat_layer_call_and_return_conditional_losses_3005�
'T2_CF_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall"B2_Concat/PartitionedCall:output:0t2_cf_batchnorm_3024t2_cf_batchnorm_3026t2_cf_batchnorm_3028t2_cf_batchnorm_3030*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� *%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_3023�
T2_CF_ReLu/PartitionedCallPartitionedCall0T2_CF_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *M
fHRF
D__inference_T2_CF_ReLu_layer_call_and_return_conditional_losses_3038�
$T2_CF_Conv2D/StatefulPartitionedCallStatefulPartitionedCall#T2_CF_ReLu/PartitionedCall:output:0t2_cf_conv2d_3048*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� *#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_T2_CF_Conv2D_layer_call_and_return_conditional_losses_3047�
T2_CF_Dropout/PartitionedCallPartitionedCall-T2_CF_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_T2_CF_Dropout_layer_call_and_return_conditional_losses_3056�
tf.compat.v1.pad_1/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
tf.compat.v1.pad_1/PadPad&T2_CF_Dropout/PartitionedCall:output:0(tf.compat.v1.pad_1/Pad/paddings:output:0*
T0*/
_output_shapes
:��������� �
T2_Pool/PartitionedCallPartitionedCalltf.compat.v1.pad_1/Pad:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *J
fERC
A__inference_T2_Pool_layer_call_and_return_conditional_losses_3064�
(B3_CF1_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall T2_Pool/PartitionedCall:output:0b3_cf1_batchnorm_3083b3_cf1_batchnorm_3085b3_cf1_batchnorm_3087b3_cf1_batchnorm_3089*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� *%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_3082�
B3_CF1_ReLu/PartitionedCallPartitionedCall1B3_CF1_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B3_CF1_ReLu_layer_call_and_return_conditional_losses_3097�
%B3_CF1_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B3_CF1_ReLu/PartitionedCall:output:0b3_cf1_conv2d_3107*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B3_CF1_Conv2D_layer_call_and_return_conditional_losses_3106�
B3_CF1_Dropout/PartitionedCallPartitionedCall.B3_CF1_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B3_CF1_Dropout_layer_call_and_return_conditional_losses_3115�
(B3_CF2_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall'B3_CF1_Dropout/PartitionedCall:output:0b3_cf2_batchnorm_3134b3_cf2_batchnorm_3136b3_cf2_batchnorm_3138b3_cf2_batchnorm_3140*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_3133�
B3_CF2_ReLu/PartitionedCallPartitionedCall1B3_CF2_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B3_CF2_ReLu_layer_call_and_return_conditional_losses_3148�
%B3_CF2_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B3_CF2_ReLu/PartitionedCall:output:0b3_cf2_conv2d_3158*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B3_CF2_Conv2D_layer_call_and_return_conditional_losses_3157�
B3_CF2_Dropout/PartitionedCallPartitionedCall.B3_CF2_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B3_CF2_Dropout_layer_call_and_return_conditional_losses_3166�
B3_Concat/PartitionedCallPartitionedCall T2_Pool/PartitionedCall:output:0'B3_CF1_Dropout/PartitionedCall:output:0'B3_CF2_Dropout/PartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_B3_Concat_layer_call_and_return_conditional_losses_3176�
'T3_CF_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall"B3_Concat/PartitionedCall:output:0t3_cf_batchnorm_3195t3_cf_batchnorm_3197t3_cf_batchnorm_3199t3_cf_batchnorm_3201*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_3194�
T3_CF_ReLu/PartitionedCallPartitionedCall0T3_CF_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *M
fHRF
D__inference_T3_CF_ReLu_layer_call_and_return_conditional_losses_3209�
$T3_CF_Conv2D/StatefulPartitionedCallStatefulPartitionedCall#T3_CF_ReLu/PartitionedCall:output:0t3_cf_conv2d_3219*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_T3_CF_Conv2D_layer_call_and_return_conditional_losses_3218�
T3_CF_Dropout/PartitionedCallPartitionedCall-T3_CF_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_T3_CF_Dropout_layer_call_and_return_conditional_losses_3227�
tf.compat.v1.pad_2/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
tf.compat.v1.pad_2/PadPad&T3_CF_Dropout/PartitionedCall:output:0(tf.compat.v1.pad_2/Pad/paddings:output:0*
T0*/
_output_shapes
:���������	(�
T3_Pool/PartitionedCallPartitionedCalltf.compat.v1.pad_2/Pad:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *J
fERC
A__inference_T3_Pool_layer_call_and_return_conditional_losses_3235�
(B4_CF1_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall T3_Pool/PartitionedCall:output:0b4_cf1_batchnorm_3254b4_cf1_batchnorm_3256b4_cf1_batchnorm_3258b4_cf1_batchnorm_3260*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_3253�
B4_CF1_ReLu/PartitionedCallPartitionedCall1B4_CF1_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B4_CF1_ReLu_layer_call_and_return_conditional_losses_3268�
%B4_CF1_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B4_CF1_ReLu/PartitionedCall:output:0b4_cf1_conv2d_3278*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B4_CF1_Conv2D_layer_call_and_return_conditional_losses_3277�
B4_CF1_Dropout/PartitionedCallPartitionedCall.B4_CF1_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B4_CF1_Dropout_layer_call_and_return_conditional_losses_3286�
B4_Concat/PartitionedCallPartitionedCall T3_Pool/PartitionedCall:output:0'B4_CF1_Dropout/PartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������,* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_B4_Concat_layer_call_and_return_conditional_losses_3295�
+batch_normalization/StatefulPartitionedCallStatefulPartitionedCall"B4_Concat/PartitionedCall:output:0batch_normalization_3314batch_normalization_3316batch_normalization_3318batch_normalization_3320*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������,*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *V
fQRO
M__inference_batch_normalization_layer_call_and_return_conditional_losses_3313�
ReLu/PartitionedCallPartitionedCall4batch_normalization/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������,* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *G
fBR@
>__inference_ReLu_layer_call_and_return_conditional_losses_3328�
(global_average_pooling2d/PartitionedCallPartitionedCallReLu/PartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������,* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *[
fVRT
R__inference_global_average_pooling2d_layer_call_and_return_conditional_losses_3335�
FC-D1/StatefulPartitionedCallStatefulPartitionedCall1global_average_pooling2d/PartitionedCall:output:0
fc_d1_3345*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *H
fCRA
?__inference_FC-D1_layer_call_and_return_conditional_losses_3344�
$BatchNorm-D1/StatefulPartitionedCallStatefulPartitionedCall&FC-D1/StatefulPartitionedCall:output:0batchnorm_d1_3348batchnorm_d1_3350batchnorm_d1_3352*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_BatchNorm-D1_layer_call_and_return_conditional_losses_2657�
Logits/StatefulPartitionedCallStatefulPartitionedCall-BatchNorm-D1/StatefulPartitionedCall:output:0logits_3367logits_3369*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *I
fDRB
@__inference_Logits_layer_call_and_return_conditional_losses_3366v
IdentityIdentity'Logits/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:����������
NoOpNoOp)^B1_CF1_BatchNorm/StatefulPartitionedCall&^B1_CF1_Conv2D/StatefulPartitionedCall)^B1_CF2_BatchNorm/StatefulPartitionedCall&^B1_CF2_Conv2D/StatefulPartitionedCall)^B2_CF1_BatchNorm/StatefulPartitionedCall&^B2_CF1_Conv2D/StatefulPartitionedCall)^B2_CF2_BatchNorm/StatefulPartitionedCall&^B2_CF2_Conv2D/StatefulPartitionedCall)^B3_CF1_BatchNorm/StatefulPartitionedCall&^B3_CF1_Conv2D/StatefulPartitionedCall)^B3_CF2_BatchNorm/StatefulPartitionedCall&^B3_CF2_Conv2D/StatefulPartitionedCall)^B4_CF1_BatchNorm/StatefulPartitionedCall&^B4_CF1_Conv2D/StatefulPartitionedCall%^BatchNorm-D1/StatefulPartitionedCall^FC-D1/StatefulPartitionedCall^Logits/StatefulPartitionedCall!^Pre_Conv/StatefulPartitionedCall(^T1_CF_BatchNorm/StatefulPartitionedCall%^T1_CF_Conv2D/StatefulPartitionedCall(^T2_CF_BatchNorm/StatefulPartitionedCall%^T2_CF_Conv2D/StatefulPartitionedCall(^T3_CF_BatchNorm/StatefulPartitionedCall%^T3_CF_Conv2D/StatefulPartitionedCall,^batch_normalization/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*�
_input_shapes�
�:���������-C: :: : : : :: : : : :: : : : :: : : : :: : : : : : : : : : : : : : :: : : : :(: : : : :(: : : : :,: : : : : : : : : 2T
(B1_CF1_BatchNorm/StatefulPartitionedCall(B1_CF1_BatchNorm/StatefulPartitionedCall2N
%B1_CF1_Conv2D/StatefulPartitionedCall%B1_CF1_Conv2D/StatefulPartitionedCall2T
(B1_CF2_BatchNorm/StatefulPartitionedCall(B1_CF2_BatchNorm/StatefulPartitionedCall2N
%B1_CF2_Conv2D/StatefulPartitionedCall%B1_CF2_Conv2D/StatefulPartitionedCall2T
(B2_CF1_BatchNorm/StatefulPartitionedCall(B2_CF1_BatchNorm/StatefulPartitionedCall2N
%B2_CF1_Conv2D/StatefulPartitionedCall%B2_CF1_Conv2D/StatefulPartitionedCall2T
(B2_CF2_BatchNorm/StatefulPartitionedCall(B2_CF2_BatchNorm/StatefulPartitionedCall2N
%B2_CF2_Conv2D/StatefulPartitionedCall%B2_CF2_Conv2D/StatefulPartitionedCall2T
(B3_CF1_BatchNorm/StatefulPartitionedCall(B3_CF1_BatchNorm/StatefulPartitionedCall2N
%B3_CF1_Conv2D/StatefulPartitionedCall%B3_CF1_Conv2D/StatefulPartitionedCall2T
(B3_CF2_BatchNorm/StatefulPartitionedCall(B3_CF2_BatchNorm/StatefulPartitionedCall2N
%B3_CF2_Conv2D/StatefulPartitionedCall%B3_CF2_Conv2D/StatefulPartitionedCall2T
(B4_CF1_BatchNorm/StatefulPartitionedCall(B4_CF1_BatchNorm/StatefulPartitionedCall2N
%B4_CF1_Conv2D/StatefulPartitionedCall%B4_CF1_Conv2D/StatefulPartitionedCall2L
$BatchNorm-D1/StatefulPartitionedCall$BatchNorm-D1/StatefulPartitionedCall2>
FC-D1/StatefulPartitionedCallFC-D1/StatefulPartitionedCall2@
Logits/StatefulPartitionedCallLogits/StatefulPartitionedCall2D
 Pre_Conv/StatefulPartitionedCall Pre_Conv/StatefulPartitionedCall2R
'T1_CF_BatchNorm/StatefulPartitionedCall'T1_CF_BatchNorm/StatefulPartitionedCall2L
$T1_CF_Conv2D/StatefulPartitionedCall$T1_CF_Conv2D/StatefulPartitionedCall2R
'T2_CF_BatchNorm/StatefulPartitionedCall'T2_CF_BatchNorm/StatefulPartitionedCall2L
$T2_CF_Conv2D/StatefulPartitionedCall$T2_CF_Conv2D/StatefulPartitionedCall2R
'T3_CF_BatchNorm/StatefulPartitionedCall'T3_CF_BatchNorm/StatefulPartitionedCall2L
$T3_CF_Conv2D/StatefulPartitionedCall$T3_CF_Conv2D/StatefulPartitionedCall2Z
+batch_normalization/StatefulPartitionedCall+batch_normalization/StatefulPartitionedCall:S O
+
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
: :  

_output_shapes
: : %

_output_shapes
:: *

_output_shapes
:(: /

_output_shapes
:(: 4

_output_shapes
:,
�

g
H__inference_B2_CF1_Dropout_layer_call_and_return_conditional_losses_4103

inputs
identity�R
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?l
dropout/MulMulinputsdropout/Const:output:0*
T0*/
_output_shapes
:���������C
dropout/ShapeShapeinputs*
T0*
_output_shapes
:�
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*/
_output_shapes
:���������*
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������w
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������q
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*/
_output_shapes
:���������a
IdentityIdentitydropout/Mul_1:z:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
,__inference_B2_CF1_Conv2D_layer_call_fn_6912

inputs!
unknown:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B2_CF1_Conv2D_layer_call_and_return_conditional_losses_2935w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������: 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
}
C__inference_B3_Concat_layer_call_and_return_conditional_losses_7680
inputs_0
inputs_1
inputs_2
identityM
concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
concatConcatV2inputs_0inputs_1inputs_2concat/axis:output:0*
N*
T0*/
_output_shapes
:���������(_
IdentityIdentityconcat:output:0*
T0*/
_output_shapes
:���������("
identityIdentity:output:0*(
_construction_contextkEagerRuntime*d
_input_shapesS
Q:��������� :���������:���������:Y U
/
_output_shapes
:��������� 
"
_user_specified_name
inputs/0:YU
/
_output_shapes
:���������
"
_user_specified_name
inputs/1:YU
/
_output_shapes
:���������
"
_user_specified_name
inputs/2
�
�
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_3819

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:����������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs: 

_output_shapes
:
�

g
H__inference_B1_CF1_Dropout_layer_call_and_return_conditional_losses_4356

inputs
identity�R
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?l
dropout/MulMulinputsdropout/Const:output:0*
T0*/
_output_shapes
:���������-CC
dropout/ShapeShapeinputs*
T0*
_output_shapes
:�
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*/
_output_shapes
:���������-C*
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������-Cw
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������-Cq
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*/
_output_shapes
:���������-Ca
IdentityIdentitydropout/Mul_1:z:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�

2
__inference__to_psd_1268
stft
identity`
Slice/beginConst*
_output_shapes
:*
dtype0*!
valueB"           _

Slice/sizeConst*
_output_shapes
:*
dtype0*!
valueB"��������-   �
SliceSlicestftSlice/begin:output:0Slice/size:output:0*
Index0*
T0*+
_output_shapes
:���������C-I
ConjConjSlice:output:0*+
_output_shapes
:���������C-_
mulMulConj:output:0Slice:output:0*
T0*+
_output_shapes
:���������C-B
RealRealmul:z:0*+
_output_shapes
:���������C-L
mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *�#08c
mul_1Mulmul_1/x:output:0Real:output:0*
T0*+
_output_shapes
:���������C-\
concat/concat_dimConst*
_output_shapes
: *
dtype0*
valueB :
���������Z
concat/concatIdentity	mul_1:z:0*
T0*+
_output_shapes
:���������C-b
IdentityIdentityconcat/concat:output:0*
T0*+
_output_shapes
:���������C-"
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:���������CA:Q M
+
_output_shapes
:���������CA

_user_specified_namestft
�
f
H__inference_B2_CF1_Dropout_layer_call_and_return_conditional_losses_2944

inputs

identity_1V
IdentityIdentityinputs*
T0*/
_output_shapes
:���������c

Identity_1IdentityIdentity:output:0*
T0*/
_output_shapes
:���������"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�

f
G__inference_T2_CF_Dropout_layer_call_and_return_conditional_losses_3935

inputs
identity�R
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?l
dropout/MulMulinputsdropout/Const:output:0*
T0*/
_output_shapes
:��������� C
dropout/ShapeShapeinputs*
T0*
_output_shapes
:�
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*/
_output_shapes
:��������� *
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:��������� w
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:��������� q
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*/
_output_shapes
:��������� a
IdentityIdentitydropout/Mul_1:z:0*
T0*/
_output_shapes
:��������� "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:��������� :W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
�
e
G__inference_T1_CF_Dropout_layer_call_and_return_conditional_losses_6743

inputs

identity_1V
IdentityIdentityinputs*
T0*/
_output_shapes
:���������-Cc

Identity_1IdentityIdentity:output:0*
T0*/
_output_shapes
:���������-C"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
e
G__inference_T1_CF_Dropout_layer_call_and_return_conditional_losses_2885

inputs

identity_1V
IdentityIdentityinputs*
T0*/
_output_shapes
:���������-Cc

Identity_1IdentityIdentity:output:0*
T0*/
_output_shapes
:���������-C"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
˕
�.
B__inference_DenseNet_layer_call_and_return_conditional_losses_5881

inputsA
'pre_conv_conv2d_readvariableop_resource:
b1_cf1_batchnorm_scale6
(b1_cf1_batchnorm_readvariableop_resource:G
9b1_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource:I
;b1_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource:F
,b1_cf1_conv2d_conv2d_readvariableop_resource:
b1_cf2_batchnorm_scale6
(b1_cf2_batchnorm_readvariableop_resource:G
9b1_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource:I
;b1_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource:F
,b1_cf2_conv2d_conv2d_readvariableop_resource:
t1_cf_batchnorm_scale5
't1_cf_batchnorm_readvariableop_resource:F
8t1_cf_batchnorm_fusedbatchnormv3_readvariableop_resource:H
:t1_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource:E
+t1_cf_conv2d_conv2d_readvariableop_resource:
b2_cf1_batchnorm_scale6
(b2_cf1_batchnorm_readvariableop_resource:G
9b2_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource:I
;b2_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource:F
,b2_cf1_conv2d_conv2d_readvariableop_resource:
b2_cf2_batchnorm_scale6
(b2_cf2_batchnorm_readvariableop_resource:G
9b2_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource:I
;b2_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource:F
,b2_cf2_conv2d_conv2d_readvariableop_resource:
t2_cf_batchnorm_scale5
't2_cf_batchnorm_readvariableop_resource: F
8t2_cf_batchnorm_fusedbatchnormv3_readvariableop_resource: H
:t2_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource: E
+t2_cf_conv2d_conv2d_readvariableop_resource:  
b3_cf1_batchnorm_scale6
(b3_cf1_batchnorm_readvariableop_resource: G
9b3_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource: I
;b3_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource: F
,b3_cf1_conv2d_conv2d_readvariableop_resource: 
b3_cf2_batchnorm_scale6
(b3_cf2_batchnorm_readvariableop_resource:G
9b3_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource:I
;b3_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource:F
,b3_cf2_conv2d_conv2d_readvariableop_resource:
t3_cf_batchnorm_scale5
't3_cf_batchnorm_readvariableop_resource:(F
8t3_cf_batchnorm_fusedbatchnormv3_readvariableop_resource:(H
:t3_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource:(E
+t3_cf_conv2d_conv2d_readvariableop_resource:((
b4_cf1_batchnorm_scale6
(b4_cf1_batchnorm_readvariableop_resource:(G
9b4_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource:(I
;b4_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource:(F
,b4_cf1_conv2d_conv2d_readvariableop_resource:(
batch_normalization_scale9
+batch_normalization_readvariableop_resource:,J
<batch_normalization_fusedbatchnormv3_readvariableop_resource:,L
>batch_normalization_fusedbatchnormv3_readvariableop_1_resource:,6
$fc_d1_matmul_readvariableop_resource:,<
.batchnorm_d1_batchnorm_readvariableop_resource:>
0batchnorm_d1_batchnorm_readvariableop_1_resource:>
0batchnorm_d1_batchnorm_readvariableop_2_resource:7
%logits_matmul_readvariableop_resource:4
&logits_biasadd_readvariableop_resource:
identity��0B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp�2B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�B1_CF1_BatchNorm/ReadVariableOp�#B1_CF1_Conv2D/Conv2D/ReadVariableOp�0B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp�2B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�B1_CF2_BatchNorm/ReadVariableOp�#B1_CF2_Conv2D/Conv2D/ReadVariableOp�0B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp�2B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�B2_CF1_BatchNorm/ReadVariableOp�#B2_CF1_Conv2D/Conv2D/ReadVariableOp�0B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp�2B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�B2_CF2_BatchNorm/ReadVariableOp�#B2_CF2_Conv2D/Conv2D/ReadVariableOp�0B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp�2B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�B3_CF1_BatchNorm/ReadVariableOp�#B3_CF1_Conv2D/Conv2D/ReadVariableOp�0B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp�2B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�B3_CF2_BatchNorm/ReadVariableOp�#B3_CF2_Conv2D/Conv2D/ReadVariableOp�0B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp�2B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�B4_CF1_BatchNorm/ReadVariableOp�#B4_CF1_Conv2D/Conv2D/ReadVariableOp�%BatchNorm-D1/batchnorm/ReadVariableOp�'BatchNorm-D1/batchnorm/ReadVariableOp_1�'BatchNorm-D1/batchnorm/ReadVariableOp_2�FC-D1/MatMul/ReadVariableOp�Logits/BiasAdd/ReadVariableOp�Logits/MatMul/ReadVariableOp�Pre_Conv/Conv2D/ReadVariableOp�/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp�1T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�T1_CF_BatchNorm/ReadVariableOp�"T1_CF_Conv2D/Conv2D/ReadVariableOp�/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp�1T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�T2_CF_BatchNorm/ReadVariableOp�"T2_CF_Conv2D/Conv2D/ReadVariableOp�/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp�1T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�T3_CF_BatchNorm/ReadVariableOp�"T3_CF_Conv2D/Conv2D/ReadVariableOp�3batch_normalization/FusedBatchNormV3/ReadVariableOp�5batch_normalization/FusedBatchNormV3/ReadVariableOp_1�"batch_normalization/ReadVariableOp_
tf.expand_dims/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B :�
tf.expand_dims/ExpandDims
ExpandDimsinputs&tf.expand_dims/ExpandDims/dim:output:0*
T0*/
_output_shapes
:���������-CU
rescaling/Cast/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<W
rescaling/Cast_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *  �?�
rescaling/mulMul"tf.expand_dims/ExpandDims:output:0rescaling/Cast/x:output:0*
T0*/
_output_shapes
:���������-C�
rescaling/addAddV2rescaling/mul:z:0rescaling/Cast_1/x:output:0*
T0*/
_output_shapes
:���������-C�
Pre_Conv/Conv2D/ReadVariableOpReadVariableOp'pre_conv_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
Pre_Conv/Conv2DConv2Drescaling/add:z:0&Pre_Conv/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
�
B1_CF1_BatchNorm/ReadVariableOpReadVariableOp(b1_cf1_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
0B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOp9b1_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
2B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp;b1_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
!B1_CF1_BatchNorm/FusedBatchNormV3FusedBatchNormV3Pre_Conv/Conv2D:output:0b1_cf1_batchnorm_scale'B1_CF1_BatchNorm/ReadVariableOp:value:08B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0:B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( y
B1_CF1_ReLu/ReluRelu%B1_CF1_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������-C�
#B1_CF1_Conv2D/Conv2D/ReadVariableOpReadVariableOp,b1_cf1_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
B1_CF1_Conv2D/Conv2DConv2DB1_CF1_ReLu/Relu:activations:0+B1_CF1_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
|
B1_CF1_Dropout/IdentityIdentityB1_CF1_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������-C�
B1_CF2_BatchNorm/ReadVariableOpReadVariableOp(b1_cf2_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
0B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOp9b1_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
2B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp;b1_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
!B1_CF2_BatchNorm/FusedBatchNormV3FusedBatchNormV3 B1_CF1_Dropout/Identity:output:0b1_cf2_batchnorm_scale'B1_CF2_BatchNorm/ReadVariableOp:value:08B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0:B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( y
B1_CF2_ReLu/ReluRelu%B1_CF2_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������-C�
#B1_CF2_Conv2D/Conv2D/ReadVariableOpReadVariableOp,b1_cf2_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
B1_CF2_Conv2D/Conv2DConv2DB1_CF2_ReLu/Relu:activations:0+B1_CF2_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
|
B1_CF2_Dropout/IdentityIdentityB1_CF2_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������-CW
B1_Concat/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
B1_Concat/concatConcatV2Pre_Conv/Conv2D:output:0 B1_CF1_Dropout/Identity:output:0 B1_CF2_Dropout/Identity:output:0B1_Concat/concat/axis:output:0*
N*
T0*/
_output_shapes
:���������-C�
T1_CF_BatchNorm/ReadVariableOpReadVariableOp't1_cf_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOp8t1_cf_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
1T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp:t1_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
 T1_CF_BatchNorm/FusedBatchNormV3FusedBatchNormV3B1_Concat/concat:output:0t1_cf_batchnorm_scale&T1_CF_BatchNorm/ReadVariableOp:value:07T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:09T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( w
T1_CF_ReLu/ReluRelu$T1_CF_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������-C�
"T1_CF_Conv2D/Conv2D/ReadVariableOpReadVariableOp+t1_cf_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
T1_CF_Conv2D/Conv2DConv2DT1_CF_ReLu/Relu:activations:0*T1_CF_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingVALID*
strides
z
T1_CF_Dropout/IdentityIdentityT1_CF_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������-C�
tf.compat.v1.pad/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
tf.compat.v1.pad/PadPadT1_CF_Dropout/Identity:output:0&tf.compat.v1.pad/Pad/paddings:output:0*
T0*/
_output_shapes
:���������-E�
T1_Pool/AvgPoolAvgPooltf.compat.v1.pad/Pad:output:0*
T0*/
_output_shapes
:���������*
ksize
*
paddingVALID*
strides
�
B2_CF1_BatchNorm/ReadVariableOpReadVariableOp(b2_cf1_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
0B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOp9b2_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
2B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp;b2_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
!B2_CF1_BatchNorm/FusedBatchNormV3FusedBatchNormV3T1_Pool/AvgPool:output:0b2_cf1_batchnorm_scale'B2_CF1_BatchNorm/ReadVariableOp:value:08B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0:B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( y
B2_CF1_ReLu/ReluRelu%B2_CF1_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:����������
#B2_CF1_Conv2D/Conv2D/ReadVariableOpReadVariableOp,b2_cf1_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
B2_CF1_Conv2D/Conv2DConv2DB2_CF1_ReLu/Relu:activations:0+B2_CF1_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
|
B2_CF1_Dropout/IdentityIdentityB2_CF1_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:����������
B2_CF2_BatchNorm/ReadVariableOpReadVariableOp(b2_cf2_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
0B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOp9b2_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
2B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp;b2_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
!B2_CF2_BatchNorm/FusedBatchNormV3FusedBatchNormV3 B2_CF1_Dropout/Identity:output:0b2_cf2_batchnorm_scale'B2_CF2_BatchNorm/ReadVariableOp:value:08B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0:B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( y
B2_CF2_ReLu/ReluRelu%B2_CF2_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:����������
#B2_CF2_Conv2D/Conv2D/ReadVariableOpReadVariableOp,b2_cf2_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
B2_CF2_Conv2D/Conv2DConv2DB2_CF2_ReLu/Relu:activations:0+B2_CF2_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
|
B2_CF2_Dropout/IdentityIdentityB2_CF2_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������W
B2_Concat/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
B2_Concat/concatConcatV2T1_Pool/AvgPool:output:0 B2_CF1_Dropout/Identity:output:0 B2_CF2_Dropout/Identity:output:0B2_Concat/concat/axis:output:0*
N*
T0*/
_output_shapes
:��������� �
T2_CF_BatchNorm/ReadVariableOpReadVariableOp't2_cf_batchnorm_readvariableop_resource*
_output_shapes
: *
dtype0�
/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOp8t2_cf_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
1T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp:t2_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
 T2_CF_BatchNorm/FusedBatchNormV3FusedBatchNormV3B2_Concat/concat:output:0t2_cf_batchnorm_scale&T2_CF_BatchNorm/ReadVariableOp:value:07T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:09T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:��������� : : : : :*
epsilon%o�:*
is_training( w
T2_CF_ReLu/ReluRelu$T2_CF_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:��������� �
"T2_CF_Conv2D/Conv2D/ReadVariableOpReadVariableOp+t2_cf_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:  *
dtype0�
T2_CF_Conv2D/Conv2DConv2DT2_CF_ReLu/Relu:activations:0*T2_CF_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:��������� *
paddingVALID*
strides
z
T2_CF_Dropout/IdentityIdentityT2_CF_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:��������� �
tf.compat.v1.pad_1/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
tf.compat.v1.pad_1/PadPadT2_CF_Dropout/Identity:output:0(tf.compat.v1.pad_1/Pad/paddings:output:0*
T0*/
_output_shapes
:��������� �
T2_Pool/AvgPoolAvgPooltf.compat.v1.pad_1/Pad:output:0*
T0*/
_output_shapes
:��������� *
ksize
*
paddingVALID*
strides
�
B3_CF1_BatchNorm/ReadVariableOpReadVariableOp(b3_cf1_batchnorm_readvariableop_resource*
_output_shapes
: *
dtype0�
0B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOp9b3_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
2B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp;b3_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
!B3_CF1_BatchNorm/FusedBatchNormV3FusedBatchNormV3T2_Pool/AvgPool:output:0b3_cf1_batchnorm_scale'B3_CF1_BatchNorm/ReadVariableOp:value:08B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0:B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:��������� : : : : :*
epsilon%o�:*
is_training( y
B3_CF1_ReLu/ReluRelu%B3_CF1_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:��������� �
#B3_CF1_Conv2D/Conv2D/ReadVariableOpReadVariableOp,b3_cf1_conv2d_conv2d_readvariableop_resource*&
_output_shapes
: *
dtype0�
B3_CF1_Conv2D/Conv2DConv2DB3_CF1_ReLu/Relu:activations:0+B3_CF1_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
|
B3_CF1_Dropout/IdentityIdentityB3_CF1_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:����������
B3_CF2_BatchNorm/ReadVariableOpReadVariableOp(b3_cf2_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
0B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOp9b3_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
2B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp;b3_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
!B3_CF2_BatchNorm/FusedBatchNormV3FusedBatchNormV3 B3_CF1_Dropout/Identity:output:0b3_cf2_batchnorm_scale'B3_CF2_BatchNorm/ReadVariableOp:value:08B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0:B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( y
B3_CF2_ReLu/ReluRelu%B3_CF2_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:����������
#B3_CF2_Conv2D/Conv2D/ReadVariableOpReadVariableOp,b3_cf2_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
B3_CF2_Conv2D/Conv2DConv2DB3_CF2_ReLu/Relu:activations:0+B3_CF2_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
|
B3_CF2_Dropout/IdentityIdentityB3_CF2_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������W
B3_Concat/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
B3_Concat/concatConcatV2T2_Pool/AvgPool:output:0 B3_CF1_Dropout/Identity:output:0 B3_CF2_Dropout/Identity:output:0B3_Concat/concat/axis:output:0*
N*
T0*/
_output_shapes
:���������(�
T3_CF_BatchNorm/ReadVariableOpReadVariableOp't3_cf_batchnorm_readvariableop_resource*
_output_shapes
:(*
dtype0�
/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOp8t3_cf_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
1T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp:t3_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
 T3_CF_BatchNorm/FusedBatchNormV3FusedBatchNormV3B3_Concat/concat:output:0t3_cf_batchnorm_scale&T3_CF_BatchNorm/ReadVariableOp:value:07T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:09T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������(:(:(:(:(:*
epsilon%o�:*
is_training( w
T3_CF_ReLu/ReluRelu$T3_CF_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������(�
"T3_CF_Conv2D/Conv2D/ReadVariableOpReadVariableOp+t3_cf_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:((*
dtype0�
T3_CF_Conv2D/Conv2DConv2DT3_CF_ReLu/Relu:activations:0*T3_CF_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������(*
paddingVALID*
strides
z
T3_CF_Dropout/IdentityIdentityT3_CF_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������(�
tf.compat.v1.pad_2/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
tf.compat.v1.pad_2/PadPadT3_CF_Dropout/Identity:output:0(tf.compat.v1.pad_2/Pad/paddings:output:0*
T0*/
_output_shapes
:���������	(�
T3_Pool/AvgPoolAvgPooltf.compat.v1.pad_2/Pad:output:0*
T0*/
_output_shapes
:���������(*
ksize
*
paddingVALID*
strides
�
B4_CF1_BatchNorm/ReadVariableOpReadVariableOp(b4_cf1_batchnorm_readvariableop_resource*
_output_shapes
:(*
dtype0�
0B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOp9b4_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
2B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp;b4_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
!B4_CF1_BatchNorm/FusedBatchNormV3FusedBatchNormV3T3_Pool/AvgPool:output:0b4_cf1_batchnorm_scale'B4_CF1_BatchNorm/ReadVariableOp:value:08B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0:B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������(:(:(:(:(:*
epsilon%o�:*
is_training( y
B4_CF1_ReLu/ReluRelu%B4_CF1_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������(�
#B4_CF1_Conv2D/Conv2D/ReadVariableOpReadVariableOp,b4_cf1_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:(*
dtype0�
B4_CF1_Conv2D/Conv2DConv2DB4_CF1_ReLu/Relu:activations:0+B4_CF1_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
|
B4_CF1_Dropout/IdentityIdentityB4_CF1_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������W
B4_Concat/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
B4_Concat/concatConcatV2T3_Pool/AvgPool:output:0 B4_CF1_Dropout/Identity:output:0B4_Concat/concat/axis:output:0*
N*
T0*/
_output_shapes
:���������,�
"batch_normalization/ReadVariableOpReadVariableOp+batch_normalization_readvariableop_resource*
_output_shapes
:,*
dtype0�
3batch_normalization/FusedBatchNormV3/ReadVariableOpReadVariableOp<batch_normalization_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:,*
dtype0�
5batch_normalization/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp>batch_normalization_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:,*
dtype0�
$batch_normalization/FusedBatchNormV3FusedBatchNormV3B4_Concat/concat:output:0batch_normalization_scale*batch_normalization/ReadVariableOp:value:0;batch_normalization/FusedBatchNormV3/ReadVariableOp:value:0=batch_normalization/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������,:,:,:,:,:*
epsilon%��'7*
is_training( u
	ReLu/ReluRelu(batch_normalization/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������,�
/global_average_pooling2d/Mean/reduction_indicesConst*
_output_shapes
:*
dtype0*
valueB"      �
global_average_pooling2d/MeanMeanReLu/Relu:activations:08global_average_pooling2d/Mean/reduction_indices:output:0*
T0*'
_output_shapes
:���������,�
FC-D1/MatMul/ReadVariableOpReadVariableOp$fc_d1_matmul_readvariableop_resource*
_output_shapes

:,*
dtype0�
FC-D1/MatMulMatMul&global_average_pooling2d/Mean:output:0#FC-D1/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:����������
%BatchNorm-D1/batchnorm/ReadVariableOpReadVariableOp.batchnorm_d1_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0a
BatchNorm-D1/batchnorm/add/yConst*
_output_shapes
: *
dtype0*
valueB
 *w�+2�
BatchNorm-D1/batchnorm/addAddV2-BatchNorm-D1/batchnorm/ReadVariableOp:value:0%BatchNorm-D1/batchnorm/add/y:output:0*
T0*
_output_shapes
:j
BatchNorm-D1/batchnorm/RsqrtRsqrtBatchNorm-D1/batchnorm/add:z:0*
T0*
_output_shapes
:�
BatchNorm-D1/batchnorm/mulMulFC-D1/MatMul:product:0 BatchNorm-D1/batchnorm/Rsqrt:y:0*
T0*'
_output_shapes
:����������
'BatchNorm-D1/batchnorm/ReadVariableOp_1ReadVariableOp0batchnorm_d1_batchnorm_readvariableop_1_resource*
_output_shapes
:*
dtype0�
BatchNorm-D1/batchnorm/mul_1Mul/BatchNorm-D1/batchnorm/ReadVariableOp_1:value:0 BatchNorm-D1/batchnorm/Rsqrt:y:0*
T0*
_output_shapes
:�
'BatchNorm-D1/batchnorm/ReadVariableOp_2ReadVariableOp0batchnorm_d1_batchnorm_readvariableop_2_resource*
_output_shapes
:*
dtype0�
BatchNorm-D1/batchnorm/subSub/BatchNorm-D1/batchnorm/ReadVariableOp_2:value:0 BatchNorm-D1/batchnorm/mul_1:z:0*
T0*
_output_shapes
:�
BatchNorm-D1/batchnorm/add_1AddV2BatchNorm-D1/batchnorm/mul:z:0BatchNorm-D1/batchnorm/sub:z:0*
T0*'
_output_shapes
:����������
Logits/MatMul/ReadVariableOpReadVariableOp%logits_matmul_readvariableop_resource*
_output_shapes

:*
dtype0�
Logits/MatMulMatMul BatchNorm-D1/batchnorm/add_1:z:0$Logits/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:����������
Logits/BiasAdd/ReadVariableOpReadVariableOp&logits_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0�
Logits/BiasAddBiasAddLogits/MatMul:product:0%Logits/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������d
Logits/SigmoidSigmoidLogits/BiasAdd:output:0*
T0*'
_output_shapes
:���������a
IdentityIdentityLogits/Sigmoid:y:0^NoOp*
T0*'
_output_shapes
:����������
NoOpNoOp1^B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp3^B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1 ^B1_CF1_BatchNorm/ReadVariableOp$^B1_CF1_Conv2D/Conv2D/ReadVariableOp1^B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp3^B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1 ^B1_CF2_BatchNorm/ReadVariableOp$^B1_CF2_Conv2D/Conv2D/ReadVariableOp1^B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp3^B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1 ^B2_CF1_BatchNorm/ReadVariableOp$^B2_CF1_Conv2D/Conv2D/ReadVariableOp1^B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp3^B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1 ^B2_CF2_BatchNorm/ReadVariableOp$^B2_CF2_Conv2D/Conv2D/ReadVariableOp1^B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp3^B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1 ^B3_CF1_BatchNorm/ReadVariableOp$^B3_CF1_Conv2D/Conv2D/ReadVariableOp1^B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp3^B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1 ^B3_CF2_BatchNorm/ReadVariableOp$^B3_CF2_Conv2D/Conv2D/ReadVariableOp1^B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp3^B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1 ^B4_CF1_BatchNorm/ReadVariableOp$^B4_CF1_Conv2D/Conv2D/ReadVariableOp&^BatchNorm-D1/batchnorm/ReadVariableOp(^BatchNorm-D1/batchnorm/ReadVariableOp_1(^BatchNorm-D1/batchnorm/ReadVariableOp_2^FC-D1/MatMul/ReadVariableOp^Logits/BiasAdd/ReadVariableOp^Logits/MatMul/ReadVariableOp^Pre_Conv/Conv2D/ReadVariableOp0^T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2^T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1^T1_CF_BatchNorm/ReadVariableOp#^T1_CF_Conv2D/Conv2D/ReadVariableOp0^T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2^T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1^T2_CF_BatchNorm/ReadVariableOp#^T2_CF_Conv2D/Conv2D/ReadVariableOp0^T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2^T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1^T3_CF_BatchNorm/ReadVariableOp#^T3_CF_Conv2D/Conv2D/ReadVariableOp4^batch_normalization/FusedBatchNormV3/ReadVariableOp6^batch_normalization/FusedBatchNormV3/ReadVariableOp_1#^batch_normalization/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*�
_input_shapes�
�:���������-C: :: : : : :: : : : :: : : : :: : : : :: : : : : : : : : : : : : : :: : : : :(: : : : :(: : : : :,: : : : : : : : : 2d
0B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp0B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp2h
2B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B
B1_CF1_BatchNorm/ReadVariableOpB1_CF1_BatchNorm/ReadVariableOp2J
#B1_CF1_Conv2D/Conv2D/ReadVariableOp#B1_CF1_Conv2D/Conv2D/ReadVariableOp2d
0B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp0B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp2h
2B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B
B1_CF2_BatchNorm/ReadVariableOpB1_CF2_BatchNorm/ReadVariableOp2J
#B1_CF2_Conv2D/Conv2D/ReadVariableOp#B1_CF2_Conv2D/Conv2D/ReadVariableOp2d
0B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp0B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp2h
2B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B
B2_CF1_BatchNorm/ReadVariableOpB2_CF1_BatchNorm/ReadVariableOp2J
#B2_CF1_Conv2D/Conv2D/ReadVariableOp#B2_CF1_Conv2D/Conv2D/ReadVariableOp2d
0B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp0B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp2h
2B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B
B2_CF2_BatchNorm/ReadVariableOpB2_CF2_BatchNorm/ReadVariableOp2J
#B2_CF2_Conv2D/Conv2D/ReadVariableOp#B2_CF2_Conv2D/Conv2D/ReadVariableOp2d
0B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp0B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp2h
2B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B
B3_CF1_BatchNorm/ReadVariableOpB3_CF1_BatchNorm/ReadVariableOp2J
#B3_CF1_Conv2D/Conv2D/ReadVariableOp#B3_CF1_Conv2D/Conv2D/ReadVariableOp2d
0B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp0B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp2h
2B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B
B3_CF2_BatchNorm/ReadVariableOpB3_CF2_BatchNorm/ReadVariableOp2J
#B3_CF2_Conv2D/Conv2D/ReadVariableOp#B3_CF2_Conv2D/Conv2D/ReadVariableOp2d
0B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp0B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp2h
2B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B
B4_CF1_BatchNorm/ReadVariableOpB4_CF1_BatchNorm/ReadVariableOp2J
#B4_CF1_Conv2D/Conv2D/ReadVariableOp#B4_CF1_Conv2D/Conv2D/ReadVariableOp2N
%BatchNorm-D1/batchnorm/ReadVariableOp%BatchNorm-D1/batchnorm/ReadVariableOp2R
'BatchNorm-D1/batchnorm/ReadVariableOp_1'BatchNorm-D1/batchnorm/ReadVariableOp_12R
'BatchNorm-D1/batchnorm/ReadVariableOp_2'BatchNorm-D1/batchnorm/ReadVariableOp_22:
FC-D1/MatMul/ReadVariableOpFC-D1/MatMul/ReadVariableOp2>
Logits/BiasAdd/ReadVariableOpLogits/BiasAdd/ReadVariableOp2<
Logits/MatMul/ReadVariableOpLogits/MatMul/ReadVariableOp2@
Pre_Conv/Conv2D/ReadVariableOpPre_Conv/Conv2D/ReadVariableOp2b
/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2f
1T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_11T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_12@
T1_CF_BatchNorm/ReadVariableOpT1_CF_BatchNorm/ReadVariableOp2H
"T1_CF_Conv2D/Conv2D/ReadVariableOp"T1_CF_Conv2D/Conv2D/ReadVariableOp2b
/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2f
1T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_11T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_12@
T2_CF_BatchNorm/ReadVariableOpT2_CF_BatchNorm/ReadVariableOp2H
"T2_CF_Conv2D/Conv2D/ReadVariableOp"T2_CF_Conv2D/Conv2D/ReadVariableOp2b
/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2f
1T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_11T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_12@
T3_CF_BatchNorm/ReadVariableOpT3_CF_BatchNorm/ReadVariableOp2H
"T3_CF_Conv2D/Conv2D/ReadVariableOp"T3_CF_Conv2D/Conv2D/ReadVariableOp2j
3batch_normalization/FusedBatchNormV3/ReadVariableOp3batch_normalization/FusedBatchNormV3/ReadVariableOp2n
5batch_normalization/FusedBatchNormV3/ReadVariableOp_15batch_normalization/FusedBatchNormV3/ReadVariableOp_12H
"batch_normalization/ReadVariableOp"batch_normalization/ReadVariableOp:S O
+
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
: :  

_output_shapes
: : %

_output_shapes
:: *

_output_shapes
:(: /

_output_shapes
:(: 4

_output_shapes
:,
�
�
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_4072

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:����������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs: 

_output_shapes
:
�
E
)__inference_T2_CF_ReLu_layer_call_fn_7257

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *M
fHRF
D__inference_T2_CF_ReLu_layer_call_and_return_conditional_losses_3038h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:��������� "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:��������� :W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
�

f
G__inference_T1_CF_Dropout_layer_call_and_return_conditional_losses_4188

inputs
identity�R
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?l
dropout/MulMulinputsdropout/Const:output:0*
T0*/
_output_shapes
:���������-CC
dropout/ShapeShapeinputs*
T0*
_output_shapes
:�
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*/
_output_shapes
:���������-C*
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������-Cw
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������-Cq
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*/
_output_shapes
:���������-Ca
IdentityIdentitydropout/Mul_1:z:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
B
&__inference_T1_Pool_layer_call_fn_6765

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *J
fERC
A__inference_T1_Pool_layer_call_and_return_conditional_losses_2893h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-E:W S
/
_output_shapes
:���������-E
 
_user_specified_nameinputs
�
�
M__inference_batch_normalization_layer_call_and_return_conditional_losses_2612

inputs	
scale%
readvariableop_resource:,6
(fusedbatchnormv3_readvariableop_resource:,8
*fusedbatchnormv3_readvariableop_1_resource:,
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:,*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:,*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:,*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������,:,:,:,:,:*
epsilon%��'7*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������,�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������,:,: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������,
 
_user_specified_nameinputs: 

_output_shapes
:,
�
�
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_6296

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_7580

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_1926

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_6653

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
f
H__inference_B2_CF1_Dropout_layer_call_and_return_conditional_losses_6934

inputs

identity_1V
IdentityIdentityinputs*
T0*/
_output_shapes
:���������c

Identity_1IdentityIdentity:output:0*
T0*/
_output_shapes
:���������"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
.__inference_T1_CF_BatchNorm_layer_call_fn_6636

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_4237w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������-C`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������-C:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:
�	
�
/__inference_B2_CF1_BatchNorm_layer_call_fn_6788

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+���������������������������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_2124�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
/__inference_B3_CF1_BatchNorm_layer_call_fn_7375

inputs
unknown
	unknown_0: 
	unknown_1: 
	unknown_2: 
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� *%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_3899w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:��������� `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':��������� : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
�
.__inference_T1_CF_BatchNorm_layer_call_fn_6623

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_2852w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������-C`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������-C:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:
�	
�
/__inference_B3_CF2_BatchNorm_layer_call_fn_7520

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+���������������������������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_2414�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
n
R__inference_global_average_pooling2d_layer_call_and_return_conditional_losses_8201

inputs
identityg
Mean/reduction_indicesConst*
_output_shapes
:*
dtype0*
valueB"      p
MeanMeaninputsMean/reduction_indices:output:0*
T0*0
_output_shapes
:������������������^
IdentityIdentityMean:output:0*
T0*0
_output_shapes
:������������������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*I
_input_shapes8
6:4������������������������������������:r n
J
_output_shapes8
6:4������������������������������������
 
_user_specified_nameinputs
�
�
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_2050

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
a
E__inference_B3_CF2_ReLu_layer_call_and_return_conditional_losses_3148

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:���������b
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
o
C__inference_B4_Concat_layer_call_and_return_conditional_losses_8055
inputs_0
inputs_1
identityM
concat/axisConst*
_output_shapes
: *
dtype0*
value	B :
concatConcatV2inputs_0inputs_1concat/axis:output:0*
N*
T0*/
_output_shapes
:���������,_
IdentityIdentityconcat:output:0*
T0*/
_output_shapes
:���������,"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*I
_input_shapes8
6:���������(:���������:Y U
/
_output_shapes
:���������(
"
_user_specified_name
inputs/0:YU
/
_output_shapes
:���������
"
_user_specified_name
inputs/1
�	
�
.__inference_T1_CF_BatchNorm_layer_call_fn_6610

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+���������������������������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_2080�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
B__inference_Pre_Conv_layer_call_and_return_conditional_losses_2720

inputs8
conv2d_readvariableop_resource:
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:���������-C^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������-C: 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�	
�
/__inference_B3_CF1_BatchNorm_layer_call_fn_7336

inputs
unknown
	unknown_0: 
	unknown_1: 
	unknown_2: 
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+��������������������������� *%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_2322�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+��������������������������� `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+��������������������������� : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+��������������������������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
F
*__inference_B1_CF1_ReLu_layer_call_fn_6352

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B1_CF1_ReLu_layer_call_and_return_conditional_losses_2755h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
b
(__inference_B1_Concat_layer_call_fn_6576
inputs_0
inputs_1
inputs_2
identity�
PartitionedCallPartitionedCallinputs_0inputs_1inputs_2*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_B1_Concat_layer_call_and_return_conditional_losses_2834h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*d
_input_shapesS
Q:���������-C:���������-C:���������-C:Y U
/
_output_shapes
:���������-C
"
_user_specified_name
inputs/0:YU
/
_output_shapes
:���������-C
"
_user_specified_name
inputs/1:YU
/
_output_shapes
:���������-C
"
_user_specified_name
inputs/2
�
a
E__inference_B1_CF2_ReLu_layer_call_and_return_conditional_losses_2806

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:���������-Cb
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
f
H__inference_B2_CF2_Dropout_layer_call_and_return_conditional_losses_2995

inputs

identity_1V
IdentityIdentityinputs*
T0*/
_output_shapes
:���������c

Identity_1IdentityIdentity:output:0*
T0*/
_output_shapes
:���������"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
M__inference_batch_normalization_layer_call_and_return_conditional_losses_3559

inputs	
scale%
readvariableop_resource:,6
(fusedbatchnormv3_readvariableop_resource:,8
*fusedbatchnormv3_readvariableop_1_resource:,
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:,*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:,*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:,*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������,:,:,:,:,:*
epsilon%��'7*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������,�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������,:,: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������,
 
_user_specified_nameinputs: 

_output_shapes
:,
�

g
H__inference_B3_CF1_Dropout_layer_call_and_return_conditional_losses_7494

inputs
identity�R
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?l
dropout/MulMulinputsdropout/Const:output:0*
T0*/
_output_shapes
:���������C
dropout/ShapeShapeinputs*
T0*
_output_shapes
:�
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*/
_output_shapes
:���������*
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������w
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������q
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*/
_output_shapes
:���������a
IdentityIdentitydropout/Mul_1:z:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
G__inference_B2_CF2_Conv2D_layer_call_and_return_conditional_losses_7090

inputs8
conv2d_readvariableop_resource:
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:���������^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������: 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
]
A__inference_T1_Pool_layer_call_and_return_conditional_losses_6775

inputs
identity�
AvgPoolAvgPoolinputs*
T0*/
_output_shapes
:���������*
ksize
*
paddingVALID*
strides
`
IdentityIdentityAvgPool:output:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-E:W S
/
_output_shapes
:���������-E
 
_user_specified_nameinputs
�
�
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_7614

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:����������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs: 

_output_shapes
:
�
E
)__inference_T3_CF_ReLu_layer_call_fn_7805

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *M
fHRF
D__inference_T3_CF_ReLu_layer_call_and_return_conditional_losses_3209h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������("
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������(:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs
�
f
-__inference_B3_CF2_Dropout_layer_call_fn_7648

inputs
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B3_CF2_Dropout_layer_call_and_return_conditional_losses_3770w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
/__inference_B2_CF1_BatchNorm_layer_call_fn_6814

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_2911w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs: 

_output_shapes
:
�
I
-__inference_B1_CF2_Dropout_layer_call_fn_6547

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B1_CF2_Dropout_layer_call_and_return_conditional_losses_2824h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
`
D__inference_T3_CF_ReLu_layer_call_and_return_conditional_losses_7810

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:���������(b
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:���������("
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������(:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs
�	
�
/__inference_B1_CF2_BatchNorm_layer_call_fn_6411

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+���������������������������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_1988�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_2962

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:����������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs: 

_output_shapes
:
�
`
D__inference_T2_CF_ReLu_layer_call_and_return_conditional_losses_7262

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:��������� b
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:��������� "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:��������� :W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
�
T
(__inference_B4_Concat_layer_call_fn_8048
inputs_0
inputs_1
identity�
PartitionedCallPartitionedCallinputs_0inputs_1*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������,* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_B4_Concat_layer_call_and_return_conditional_losses_3295h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������,"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*I
_input_shapes8
6:���������(:���������:Y U
/
_output_shapes
:���������(
"
_user_specified_name
inputs/0:YU
/
_output_shapes
:���������
"
_user_specified_name
inputs/1
�

f
G__inference_T3_CF_Dropout_layer_call_and_return_conditional_losses_3682

inputs
identity�R
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?l
dropout/MulMulinputsdropout/Const:output:0*
T0*/
_output_shapes
:���������(C
dropout/ShapeShapeinputs*
T0*
_output_shapes
:�
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*/
_output_shapes
:���������(*
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������(w
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������(q
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*/
_output_shapes
:���������(a
IdentityIdentitydropout/Mul_1:z:0*
T0*/
_output_shapes
:���������("
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������(:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs
�	
�
2__inference_batch_normalization_layer_call_fn_8081

inputs
unknown
	unknown_0:,
	unknown_1:,
	unknown_2:,
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+���������������������������,*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *V
fQRO
M__inference_batch_normalization_layer_call_and_return_conditional_losses_2612�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������,`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������,:,: : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+���������������������������,
 
_user_specified_nameinputs: 

_output_shapes
:,
�
�
2__inference_batch_normalization_layer_call_fn_8094

inputs
unknown
	unknown_0:,
	unknown_1:,
	unknown_2:,
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������,*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *V
fQRO
M__inference_batch_normalization_layer_call_and_return_conditional_losses_3313w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������,`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������,:,: : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������,
 
_user_specified_nameinputs: 

_output_shapes
:,
�
�
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_4237

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������-C�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������-C:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_3984

inputs	
scale%
readvariableop_resource: 6
(fusedbatchnormv3_readvariableop_resource: 8
*fusedbatchnormv3_readvariableop_1_resource: 
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:��������� : : : : :*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:��������� �
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':��������� : : : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
�
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_2352

inputs	
scale%
readvariableop_resource: 6
(fusedbatchnormv3_readvariableop_resource: 8
*fusedbatchnormv3_readvariableop_1_resource: 
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+��������������������������� : : : : :*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+��������������������������� �
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+��������������������������� : : : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+��������������������������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
]
A__inference_T2_Pool_layer_call_and_return_conditional_losses_7318

inputs
identity�
AvgPoolAvgPoolinputs*
T0*J
_output_shapes8
6:4������������������������������������*
ksize
*
paddingVALID*
strides
{
IdentityIdentityAvgPool:output:0*
T0*J
_output_shapes8
6:4������������������������������������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*I
_input_shapes8
6:4������������������������������������:r n
J
_output_shapes8
6:4������������������������������������
 
_user_specified_nameinputs
�
`
D__inference_T1_CF_ReLu_layer_call_and_return_conditional_losses_2867

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:���������-Cb
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
�
+__inference_T2_CF_Conv2D_layer_call_fn_7269

inputs!
unknown:  
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� *#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_T2_CF_Conv2D_layer_call_and_return_conditional_losses_3047w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:��������� `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:��������� : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
�
�
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_7218

inputs	
scale%
readvariableop_resource: 6
(fusedbatchnormv3_readvariableop_resource: 8
*fusedbatchnormv3_readvariableop_1_resource: 
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+��������������������������� : : : : :*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+��������������������������� �
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+��������������������������� : : : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+��������������������������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
]
A__inference_T2_Pool_layer_call_and_return_conditional_losses_7323

inputs
identity�
AvgPoolAvgPoolinputs*
T0*/
_output_shapes
:��������� *
ksize
*
paddingVALID*
strides
`
IdentityIdentityAvgPool:output:0*
T0*/
_output_shapes
:��������� "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:��������� :W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
�
�
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_6844

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�

f
G__inference_T2_CF_Dropout_layer_call_and_return_conditional_losses_7303

inputs
identity�R
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?l
dropout/MulMulinputsdropout/Const:output:0*
T0*/
_output_shapes
:��������� C
dropout/ShapeShapeinputs*
T0*
_output_shapes
:�
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*/
_output_shapes
:��������� *
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:��������� w
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:��������� q
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*/
_output_shapes
:��������� a
IdentityIdentitydropout/Mul_1:z:0*
T0*/
_output_shapes
:��������� "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:��������� :W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
�
e
G__inference_T3_CF_Dropout_layer_call_and_return_conditional_losses_7839

inputs

identity_1V
IdentityIdentityinputs*
T0*/
_output_shapes
:���������(c

Identity_1IdentityIdentity:output:0*
T0*/
_output_shapes
:���������("!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������(:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs
�
�
"__inference_signature_wrapper_1655

inputs!
unknown:
	unknown_0
	unknown_1:
	unknown_2:
	unknown_3:#
	unknown_4:
	unknown_5
	unknown_6:
	unknown_7:
	unknown_8:#
	unknown_9:

unknown_10

unknown_11:

unknown_12:

unknown_13:$

unknown_14:

unknown_15

unknown_16:

unknown_17:

unknown_18:$

unknown_19:

unknown_20

unknown_21:

unknown_22:

unknown_23:$

unknown_24:

unknown_25

unknown_26: 

unknown_27: 

unknown_28: $

unknown_29:  

unknown_30

unknown_31: 

unknown_32: 

unknown_33: $

unknown_34: 

unknown_35

unknown_36:

unknown_37:

unknown_38:$

unknown_39:

unknown_40

unknown_41:(

unknown_42:(

unknown_43:($

unknown_44:((

unknown_45

unknown_46:(

unknown_47:(

unknown_48:($

unknown_49:(

unknown_50

unknown_51:,

unknown_52:,

unknown_53:,

unknown_54:,

unknown_55:

unknown_56:

unknown_57:

unknown_58:

unknown_59:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4	unknown_5	unknown_6	unknown_7	unknown_8	unknown_9
unknown_10
unknown_11
unknown_12
unknown_13
unknown_14
unknown_15
unknown_16
unknown_17
unknown_18
unknown_19
unknown_20
unknown_21
unknown_22
unknown_23
unknown_24
unknown_25
unknown_26
unknown_27
unknown_28
unknown_29
unknown_30
unknown_31
unknown_32
unknown_33
unknown_34
unknown_35
unknown_36
unknown_37
unknown_38
unknown_39
unknown_40
unknown_41
unknown_42
unknown_43
unknown_44
unknown_45
unknown_46
unknown_47
unknown_48
unknown_49
unknown_50
unknown_51
unknown_52
unknown_53
unknown_54
unknown_55
unknown_56
unknown_57
unknown_58
unknown_59*I
TinB
@2>*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*T
_read_only_resource_inputs6
42	
!"#$&'()+,-.012356789:;<=*-
config_proto

CPU

GPU 2J 8� *-
f(R&
$__inference_with_transformation_1526o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*�
_input_shapes�
�:����������: :: : : : :: : : : :: : : : :: : : : :: : : : : : : : : : : : : : :: : : : :(: : : : :(: : : : :,: : : : : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:P L
(
_output_shapes
:����������
 
_user_specified_nameinputs: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
: :  

_output_shapes
: : %

_output_shapes
:: *

_output_shapes
:(: /

_output_shapes
:(: 4

_output_shapes
:,
�
�
+__inference_T1_CF_Conv2D_layer_call_fn_6721

inputs!
unknown:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_T1_CF_Conv2D_layer_call_and_return_conditional_losses_2876w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������-C`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������-C: 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
�
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_4405

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������-C�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������-C:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_2740

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������-C�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������-C:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_7749

inputs	
scale%
readvariableop_resource:(6
(fusedbatchnormv3_readvariableop_resource:(8
*fusedbatchnormv3_readvariableop_1_resource:(
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������(:(:(:(:(:*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������(�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������(:(: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�
{
C__inference_B3_Concat_layer_call_and_return_conditional_losses_3176

inputs
inputs_1
inputs_2
identityM
concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
concatConcatV2inputsinputs_1inputs_2concat/axis:output:0*
N*
T0*/
_output_shapes
:���������(_
IdentityIdentityconcat:output:0*
T0*/
_output_shapes
:���������("
identityIdentity:output:0*(
_construction_contextkEagerRuntime*d
_input_shapesS
Q:��������� :���������:���������:W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs:WS
/
_output_shapes
:���������
 
_user_specified_nameinputs:WS
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
/__inference_B2_CF1_BatchNorm_layer_call_fn_6827

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_4152w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_7563

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_2791

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������-C�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������-C:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:
�
I
-__inference_B2_CF1_Dropout_layer_call_fn_6924

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B2_CF1_Dropout_layer_call_and_return_conditional_losses_2944h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
a
E__inference_B2_CF1_ReLu_layer_call_and_return_conditional_losses_6905

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:���������b
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
m
C__inference_B4_Concat_layer_call_and_return_conditional_losses_3295

inputs
inputs_1
identityM
concat/axisConst*
_output_shapes
: *
dtype0*
value	B :}
concatConcatV2inputsinputs_1concat/axis:output:0*
N*
T0*/
_output_shapes
:���������,_
IdentityIdentityconcat:output:0*
T0*/
_output_shapes
:���������,"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*I
_input_shapes8
6:���������(:���������:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs:WS
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
f
H__inference_B3_CF1_Dropout_layer_call_and_return_conditional_losses_7482

inputs

identity_1V
IdentityIdentityinputs*
T0*/
_output_shapes
:���������c

Identity_1IdentityIdentity:output:0*
T0*/
_output_shapes
:���������"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_7443

inputs	
scale%
readvariableop_resource: 6
(fusedbatchnormv3_readvariableop_resource: 8
*fusedbatchnormv3_readvariableop_1_resource: 
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:��������� : : : : :*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:��������� �
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':��������� : : : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
�
,__inference_B4_CF1_Conv2D_layer_call_fn_8008

inputs!
unknown:(
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B4_CF1_Conv2D_layer_call_and_return_conditional_losses_3277w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������(: 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs
�
�
F__inference_BatchNorm-D1_layer_call_and_return_conditional_losses_2657

inputs/
!batchnorm_readvariableop_resource:1
#batchnorm_readvariableop_1_resource:1
#batchnorm_readvariableop_2_resource:
identity��batchnorm/ReadVariableOp�batchnorm/ReadVariableOp_1�batchnorm/ReadVariableOp_2v
batchnorm/ReadVariableOpReadVariableOp!batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0T
batchnorm/add/yConst*
_output_shapes
: *
dtype0*
valueB
 *w�+2w
batchnorm/addAddV2 batchnorm/ReadVariableOp:value:0batchnorm/add/y:output:0*
T0*
_output_shapes
:P
batchnorm/RsqrtRsqrtbatchnorm/add:z:0*
T0*
_output_shapes
:c
batchnorm/mulMulinputsbatchnorm/Rsqrt:y:0*
T0*'
_output_shapes
:���������z
batchnorm/ReadVariableOp_1ReadVariableOp#batchnorm_readvariableop_1_resource*
_output_shapes
:*
dtype0t
batchnorm/mul_1Mul"batchnorm/ReadVariableOp_1:value:0batchnorm/Rsqrt:y:0*
T0*
_output_shapes
:z
batchnorm/ReadVariableOp_2ReadVariableOp#batchnorm_readvariableop_2_resource*
_output_shapes
:*
dtype0r
batchnorm/subSub"batchnorm/ReadVariableOp_2:value:0batchnorm/mul_1:z:0*
T0*
_output_shapes
:p
batchnorm/add_1AddV2batchnorm/mul:z:0batchnorm/sub:z:0*
T0*'
_output_shapes
:���������b
IdentityIdentitybatchnorm/add_1:z:0^NoOp*
T0*'
_output_shapes
:����������
NoOpNoOp^batchnorm/ReadVariableOp^batchnorm/ReadVariableOp_1^batchnorm/ReadVariableOp_2*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*,
_input_shapes
:���������: : : 24
batchnorm/ReadVariableOpbatchnorm/ReadVariableOp28
batchnorm/ReadVariableOp_1batchnorm/ReadVariableOp_128
batchnorm/ReadVariableOp_2batchnorm/ReadVariableOp_2:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�
S
7__inference_global_average_pooling2d_layer_call_fn_8190

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *0
_output_shapes
:������������������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *[
fVRT
R__inference_global_average_pooling2d_layer_call_and_return_conditional_losses_2633i
IdentityIdentityPartitionedCall:output:0*
T0*0
_output_shapes
:������������������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*I
_input_shapes8
6:4������������������������������������:r n
J
_output_shapes8
6:4������������������������������������
 
_user_specified_nameinputs
�

g
H__inference_B4_CF1_Dropout_layer_call_and_return_conditional_losses_3597

inputs
identity�R
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?l
dropout/MulMulinputsdropout/Const:output:0*
T0*/
_output_shapes
:���������C
dropout/ShapeShapeinputs*
T0*
_output_shapes
:�
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*/
_output_shapes
:���������*
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������w
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������q
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*/
_output_shapes
:���������a
IdentityIdentitydropout/Mul_1:z:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_7409

inputs	
scale%
readvariableop_resource: 6
(fusedbatchnormv3_readvariableop_resource: 8
*fusedbatchnormv3_readvariableop_1_resource: 
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+��������������������������� : : : : :*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+��������������������������� �
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+��������������������������� : : : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+��������������������������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
�
+__inference_T3_CF_Conv2D_layer_call_fn_7817

inputs!
unknown:((
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_T3_CF_Conv2D_layer_call_and_return_conditional_losses_3218w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������(`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������(: 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs
�
f
H__inference_B1_CF2_Dropout_layer_call_and_return_conditional_losses_2824

inputs

identity_1V
IdentityIdentityinputs*
T0*/
_output_shapes
:���������-Cc

Identity_1IdentityIdentity:output:0*
T0*/
_output_shapes
:���������-C"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
�
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_2322

inputs	
scale%
readvariableop_resource: 6
(fusedbatchnormv3_readvariableop_resource: 8
*fusedbatchnormv3_readvariableop_1_resource: 
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+��������������������������� : : : : :*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+��������������������������� �
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+��������������������������� : : : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+��������������������������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
�
/__inference_B4_CF1_BatchNorm_layer_call_fn_7910

inputs
unknown
	unknown_0:(
	unknown_1:(
	unknown_2:(
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_3253w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������(`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������(:(: : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�
�
G__inference_B4_CF1_Conv2D_layer_call_and_return_conditional_losses_3277

inputs8
conv2d_readvariableop_resource:(
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
:(*
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:���������^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������(: 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs
�
�
F__inference_T1_CF_Conv2D_layer_call_and_return_conditional_losses_2876

inputs8
conv2d_readvariableop_resource:
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingVALID*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:���������-C^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������-C: 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
�
.__inference_T2_CF_BatchNorm_layer_call_fn_7184

inputs
unknown
	unknown_0: 
	unknown_1: 
	unknown_2: 
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� *%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_3984w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:��������� `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':��������� : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
F
*__inference_B3_CF1_ReLu_layer_call_fn_7448

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B3_CF1_ReLu_layer_call_and_return_conditional_losses_3097h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:��������� "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:��������� :W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
�
�
/__inference_B4_CF1_BatchNorm_layer_call_fn_7923

inputs
unknown
	unknown_0:(
	unknown_1:(
	unknown_2:(
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_3646w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������(`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������(:(: : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�
�
F__inference_BatchNorm-D1_layer_call_and_return_conditional_losses_8260

inputs/
!batchnorm_readvariableop_resource:1
#batchnorm_readvariableop_1_resource:1
#batchnorm_readvariableop_2_resource:
identity��batchnorm/ReadVariableOp�batchnorm/ReadVariableOp_1�batchnorm/ReadVariableOp_2v
batchnorm/ReadVariableOpReadVariableOp!batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0T
batchnorm/add/yConst*
_output_shapes
: *
dtype0*
valueB
 *w�+2w
batchnorm/addAddV2 batchnorm/ReadVariableOp:value:0batchnorm/add/y:output:0*
T0*
_output_shapes
:P
batchnorm/RsqrtRsqrtbatchnorm/add:z:0*
T0*
_output_shapes
:c
batchnorm/mulMulinputsbatchnorm/Rsqrt:y:0*
T0*'
_output_shapes
:���������z
batchnorm/ReadVariableOp_1ReadVariableOp#batchnorm_readvariableop_1_resource*
_output_shapes
:*
dtype0t
batchnorm/mul_1Mul"batchnorm/ReadVariableOp_1:value:0batchnorm/Rsqrt:y:0*
T0*
_output_shapes
:z
batchnorm/ReadVariableOp_2ReadVariableOp#batchnorm_readvariableop_2_resource*
_output_shapes
:*
dtype0r
batchnorm/subSub"batchnorm/ReadVariableOp_2:value:0batchnorm/mul_1:z:0*
T0*
_output_shapes
:p
batchnorm/add_1AddV2batchnorm/mul:z:0batchnorm/sub:z:0*
T0*'
_output_shapes
:���������b
IdentityIdentitybatchnorm/add_1:z:0^NoOp*
T0*'
_output_shapes
:����������
NoOpNoOp^batchnorm/ReadVariableOp^batchnorm/ReadVariableOp_1^batchnorm/ReadVariableOp_2*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*,
_input_shapes
:���������: : : 24
batchnorm/ReadVariableOpbatchnorm/ReadVariableOp28
batchnorm/ReadVariableOp_1batchnorm/ReadVariableOp_128
batchnorm/ReadVariableOp_2batchnorm/ReadVariableOp_2:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�	
�
/__inference_B1_CF1_BatchNorm_layer_call_fn_6253

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+���������������������������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_1956�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
G__inference_B3_CF1_Conv2D_layer_call_and_return_conditional_losses_3106

inputs8
conv2d_readvariableop_resource: 
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
: *
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:���������^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:��������� : 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
�
�
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_6518

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������-C�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������-C:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:
�
Z
>__inference_ReLu_layer_call_and_return_conditional_losses_8185

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:���������,b
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:���������,"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������,:W S
/
_output_shapes
:���������,
 
_user_specified_nameinputs
�
H
,__inference_T3_CF_Dropout_layer_call_fn_7829

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_T3_CF_Dropout_layer_call_and_return_conditional_losses_3227h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������("
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������(:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs
�

�
@__inference_Logits_layer_call_and_return_conditional_losses_3366

inputs0
matmul_readvariableop_resource:-
biasadd_readvariableop_resource:
identity��BiasAdd/ReadVariableOp�MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������V
SigmoidSigmoidBiasAdd:output:0*
T0*'
_output_shapes
:���������Z
IdentityIdentitySigmoid:y:0^NoOp*
T0*'
_output_shapes
:���������w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:���������: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_6878

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:����������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs: 

_output_shapes
:
�
]
A__inference_T3_Pool_layer_call_and_return_conditional_losses_7871

inputs
identity�
AvgPoolAvgPoolinputs*
T0*/
_output_shapes
:���������(*
ksize
*
paddingVALID*
strides
`
IdentityIdentityAvgPool:output:0*
T0*/
_output_shapes
:���������("
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������	(:W S
/
_output_shapes
:���������	(
 
_user_specified_nameinputs
�
�
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_2476

inputs	
scale%
readvariableop_resource:(6
(fusedbatchnormv3_readvariableop_resource:(8
*fusedbatchnormv3_readvariableop_1_resource:(
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������(:(:(:(:(:*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������(�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������(:(: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�
�
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_7252

inputs	
scale%
readvariableop_resource: 6
(fusedbatchnormv3_readvariableop_resource: 8
*fusedbatchnormv3_readvariableop_1_resource: 
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:��������� : : : : :*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:��������� �
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':��������� : : : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
]
A__inference_T2_Pool_layer_call_and_return_conditional_losses_3064

inputs
identity�
AvgPoolAvgPoolinputs*
T0*/
_output_shapes
:��������� *
ksize
*
paddingVALID*
strides
`
IdentityIdentityAvgPool:output:0*
T0*/
_output_shapes
:��������� "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:��������� :W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
�
�
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_7426

inputs	
scale%
readvariableop_resource: 6
(fusedbatchnormv3_readvariableop_resource: 8
*fusedbatchnormv3_readvariableop_1_resource: 
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:��������� : : : : :*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:��������� �
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':��������� : : : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
?
#__inference_ReLu_layer_call_fn_8180

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������,* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *G
fBR@
>__inference_ReLu_layer_call_and_return_conditional_losses_3328h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������,"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������,:W S
/
_output_shapes
:���������,
 
_user_specified_nameinputs
�
�5
__inference_basic_1004

inputsJ
0densenet_pre_conv_conv2d_readvariableop_resource:#
densenet_b1_cf1_batchnorm_scale?
1densenet_b1_cf1_batchnorm_readvariableop_resource:P
Bdensenet_b1_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource:R
Ddensenet_b1_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource:O
5densenet_b1_cf1_conv2d_conv2d_readvariableop_resource:#
densenet_b1_cf2_batchnorm_scale?
1densenet_b1_cf2_batchnorm_readvariableop_resource:P
Bdensenet_b1_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource:R
Ddensenet_b1_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource:O
5densenet_b1_cf2_conv2d_conv2d_readvariableop_resource:"
densenet_t1_cf_batchnorm_scale>
0densenet_t1_cf_batchnorm_readvariableop_resource:O
Adensenet_t1_cf_batchnorm_fusedbatchnormv3_readvariableop_resource:Q
Cdensenet_t1_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource:N
4densenet_t1_cf_conv2d_conv2d_readvariableop_resource:#
densenet_b2_cf1_batchnorm_scale?
1densenet_b2_cf1_batchnorm_readvariableop_resource:P
Bdensenet_b2_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource:R
Ddensenet_b2_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource:O
5densenet_b2_cf1_conv2d_conv2d_readvariableop_resource:#
densenet_b2_cf2_batchnorm_scale?
1densenet_b2_cf2_batchnorm_readvariableop_resource:P
Bdensenet_b2_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource:R
Ddensenet_b2_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource:O
5densenet_b2_cf2_conv2d_conv2d_readvariableop_resource:"
densenet_t2_cf_batchnorm_scale>
0densenet_t2_cf_batchnorm_readvariableop_resource: O
Adensenet_t2_cf_batchnorm_fusedbatchnormv3_readvariableop_resource: Q
Cdensenet_t2_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource: N
4densenet_t2_cf_conv2d_conv2d_readvariableop_resource:  #
densenet_b3_cf1_batchnorm_scale?
1densenet_b3_cf1_batchnorm_readvariableop_resource: P
Bdensenet_b3_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource: R
Ddensenet_b3_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource: O
5densenet_b3_cf1_conv2d_conv2d_readvariableop_resource: #
densenet_b3_cf2_batchnorm_scale?
1densenet_b3_cf2_batchnorm_readvariableop_resource:P
Bdensenet_b3_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource:R
Ddensenet_b3_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource:O
5densenet_b3_cf2_conv2d_conv2d_readvariableop_resource:"
densenet_t3_cf_batchnorm_scale>
0densenet_t3_cf_batchnorm_readvariableop_resource:(O
Adensenet_t3_cf_batchnorm_fusedbatchnormv3_readvariableop_resource:(Q
Cdensenet_t3_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource:(N
4densenet_t3_cf_conv2d_conv2d_readvariableop_resource:((#
densenet_b4_cf1_batchnorm_scale?
1densenet_b4_cf1_batchnorm_readvariableop_resource:(P
Bdensenet_b4_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource:(R
Ddensenet_b4_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource:(O
5densenet_b4_cf1_conv2d_conv2d_readvariableop_resource:(&
"densenet_batch_normalization_scaleB
4densenet_batch_normalization_readvariableop_resource:,S
Edensenet_batch_normalization_fusedbatchnormv3_readvariableop_resource:,U
Gdensenet_batch_normalization_fusedbatchnormv3_readvariableop_1_resource:,?
-densenet_fc_d1_matmul_readvariableop_resource:,E
7densenet_batchnorm_d1_batchnorm_readvariableop_resource:G
9densenet_batchnorm_d1_batchnorm_readvariableop_1_resource:G
9densenet_batchnorm_d1_batchnorm_readvariableop_2_resource:@
.densenet_logits_matmul_readvariableop_resource:=
/densenet_logits_biasadd_readvariableop_resource:
identity��9DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B1_CF1_BatchNorm/ReadVariableOp�,DenseNet/B1_CF1_Conv2D/Conv2D/ReadVariableOp�9DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B1_CF2_BatchNorm/ReadVariableOp�,DenseNet/B1_CF2_Conv2D/Conv2D/ReadVariableOp�9DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B2_CF1_BatchNorm/ReadVariableOp�,DenseNet/B2_CF1_Conv2D/Conv2D/ReadVariableOp�9DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B2_CF2_BatchNorm/ReadVariableOp�,DenseNet/B2_CF2_Conv2D/Conv2D/ReadVariableOp�9DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B3_CF1_BatchNorm/ReadVariableOp�,DenseNet/B3_CF1_Conv2D/Conv2D/ReadVariableOp�9DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B3_CF2_BatchNorm/ReadVariableOp�,DenseNet/B3_CF2_Conv2D/Conv2D/ReadVariableOp�9DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B4_CF1_BatchNorm/ReadVariableOp�,DenseNet/B4_CF1_Conv2D/Conv2D/ReadVariableOp�.DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp�0DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_1�0DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_2�$DenseNet/FC-D1/MatMul/ReadVariableOp�&DenseNet/Logits/BiasAdd/ReadVariableOp�%DenseNet/Logits/MatMul/ReadVariableOp�'DenseNet/Pre_Conv/Conv2D/ReadVariableOp�8DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp�:DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�'DenseNet/T1_CF_BatchNorm/ReadVariableOp�+DenseNet/T1_CF_Conv2D/Conv2D/ReadVariableOp�8DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp�:DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�'DenseNet/T2_CF_BatchNorm/ReadVariableOp�+DenseNet/T2_CF_Conv2D/Conv2D/ReadVariableOp�8DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp�:DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�'DenseNet/T3_CF_BatchNorm/ReadVariableOp�+DenseNet/T3_CF_Conv2D/Conv2D/ReadVariableOp�<DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp�>DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp_1�+DenseNet/batch_normalization/ReadVariableOph
&DenseNet/tf.expand_dims/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B :�
"DenseNet/tf.expand_dims/ExpandDims
ExpandDimsinputs/DenseNet/tf.expand_dims/ExpandDims/dim:output:0*
T0*/
_output_shapes
:���������-C^
DenseNet/rescaling/Cast/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<`
DenseNet/rescaling/Cast_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *  �?�
DenseNet/rescaling/mulMul+DenseNet/tf.expand_dims/ExpandDims:output:0"DenseNet/rescaling/Cast/x:output:0*
T0*/
_output_shapes
:���������-C�
DenseNet/rescaling/addAddV2DenseNet/rescaling/mul:z:0$DenseNet/rescaling/Cast_1/x:output:0*
T0*/
_output_shapes
:���������-C�
'DenseNet/Pre_Conv/Conv2D/ReadVariableOpReadVariableOp0densenet_pre_conv_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/Pre_Conv/Conv2DConv2DDenseNet/rescaling/add:z:0/DenseNet/Pre_Conv/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
�
(DenseNet/B1_CF1_BatchNorm/ReadVariableOpReadVariableOp1densenet_b1_cf1_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
9DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b1_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
;DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b1_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
*DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3FusedBatchNormV3!DenseNet/Pre_Conv/Conv2D:output:0densenet_b1_cf1_batchnorm_scale0DenseNet/B1_CF1_BatchNorm/ReadVariableOp:value:0ADenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( �
DenseNet/B1_CF1_ReLu/ReluRelu.DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������-C�
,DenseNet/B1_CF1_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b1_cf1_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/B1_CF1_Conv2D/Conv2DConv2D'DenseNet/B1_CF1_ReLu/Relu:activations:04DenseNet/B1_CF1_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
�
 DenseNet/B1_CF1_Dropout/IdentityIdentity&DenseNet/B1_CF1_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������-C�
(DenseNet/B1_CF2_BatchNorm/ReadVariableOpReadVariableOp1densenet_b1_cf2_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
9DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b1_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
;DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b1_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
*DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3FusedBatchNormV3)DenseNet/B1_CF1_Dropout/Identity:output:0densenet_b1_cf2_batchnorm_scale0DenseNet/B1_CF2_BatchNorm/ReadVariableOp:value:0ADenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( �
DenseNet/B1_CF2_ReLu/ReluRelu.DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������-C�
,DenseNet/B1_CF2_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b1_cf2_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/B1_CF2_Conv2D/Conv2DConv2D'DenseNet/B1_CF2_ReLu/Relu:activations:04DenseNet/B1_CF2_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
�
 DenseNet/B1_CF2_Dropout/IdentityIdentity&DenseNet/B1_CF2_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������-C`
DenseNet/B1_Concat/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
DenseNet/B1_Concat/concatConcatV2!DenseNet/Pre_Conv/Conv2D:output:0)DenseNet/B1_CF1_Dropout/Identity:output:0)DenseNet/B1_CF2_Dropout/Identity:output:0'DenseNet/B1_Concat/concat/axis:output:0*
N*
T0*/
_output_shapes
:���������-C�
'DenseNet/T1_CF_BatchNorm/ReadVariableOpReadVariableOp0densenet_t1_cf_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
8DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpAdensenet_t1_cf_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
:DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpCdensenet_t1_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
)DenseNet/T1_CF_BatchNorm/FusedBatchNormV3FusedBatchNormV3"DenseNet/B1_Concat/concat:output:0densenet_t1_cf_batchnorm_scale/DenseNet/T1_CF_BatchNorm/ReadVariableOp:value:0@DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0BDenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( �
DenseNet/T1_CF_ReLu/ReluRelu-DenseNet/T1_CF_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������-C�
+DenseNet/T1_CF_Conv2D/Conv2D/ReadVariableOpReadVariableOp4densenet_t1_cf_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/T1_CF_Conv2D/Conv2DConv2D&DenseNet/T1_CF_ReLu/Relu:activations:03DenseNet/T1_CF_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingVALID*
strides
�
DenseNet/T1_CF_Dropout/IdentityIdentity%DenseNet/T1_CF_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������-C�
&DenseNet/tf.compat.v1.pad/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
DenseNet/tf.compat.v1.pad/PadPad(DenseNet/T1_CF_Dropout/Identity:output:0/DenseNet/tf.compat.v1.pad/Pad/paddings:output:0*
T0*/
_output_shapes
:���������-E�
DenseNet/T1_Pool/AvgPoolAvgPool&DenseNet/tf.compat.v1.pad/Pad:output:0*
T0*/
_output_shapes
:���������*
ksize
*
paddingVALID*
strides
�
(DenseNet/B2_CF1_BatchNorm/ReadVariableOpReadVariableOp1densenet_b2_cf1_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
9DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b2_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
;DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b2_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
*DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3FusedBatchNormV3!DenseNet/T1_Pool/AvgPool:output:0densenet_b2_cf1_batchnorm_scale0DenseNet/B2_CF1_BatchNorm/ReadVariableOp:value:0ADenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( �
DenseNet/B2_CF1_ReLu/ReluRelu.DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:����������
,DenseNet/B2_CF1_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b2_cf1_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/B2_CF1_Conv2D/Conv2DConv2D'DenseNet/B2_CF1_ReLu/Relu:activations:04DenseNet/B2_CF1_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
�
 DenseNet/B2_CF1_Dropout/IdentityIdentity&DenseNet/B2_CF1_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:����������
(DenseNet/B2_CF2_BatchNorm/ReadVariableOpReadVariableOp1densenet_b2_cf2_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
9DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b2_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
;DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b2_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
*DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3FusedBatchNormV3)DenseNet/B2_CF1_Dropout/Identity:output:0densenet_b2_cf2_batchnorm_scale0DenseNet/B2_CF2_BatchNorm/ReadVariableOp:value:0ADenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( �
DenseNet/B2_CF2_ReLu/ReluRelu.DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:����������
,DenseNet/B2_CF2_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b2_cf2_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/B2_CF2_Conv2D/Conv2DConv2D'DenseNet/B2_CF2_ReLu/Relu:activations:04DenseNet/B2_CF2_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
�
 DenseNet/B2_CF2_Dropout/IdentityIdentity&DenseNet/B2_CF2_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������`
DenseNet/B2_Concat/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
DenseNet/B2_Concat/concatConcatV2!DenseNet/T1_Pool/AvgPool:output:0)DenseNet/B2_CF1_Dropout/Identity:output:0)DenseNet/B2_CF2_Dropout/Identity:output:0'DenseNet/B2_Concat/concat/axis:output:0*
N*
T0*/
_output_shapes
:��������� �
'DenseNet/T2_CF_BatchNorm/ReadVariableOpReadVariableOp0densenet_t2_cf_batchnorm_readvariableop_resource*
_output_shapes
: *
dtype0�
8DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpAdensenet_t2_cf_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
:DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpCdensenet_t2_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
)DenseNet/T2_CF_BatchNorm/FusedBatchNormV3FusedBatchNormV3"DenseNet/B2_Concat/concat:output:0densenet_t2_cf_batchnorm_scale/DenseNet/T2_CF_BatchNorm/ReadVariableOp:value:0@DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0BDenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:��������� : : : : :*
epsilon%o�:*
is_training( �
DenseNet/T2_CF_ReLu/ReluRelu-DenseNet/T2_CF_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:��������� �
+DenseNet/T2_CF_Conv2D/Conv2D/ReadVariableOpReadVariableOp4densenet_t2_cf_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:  *
dtype0�
DenseNet/T2_CF_Conv2D/Conv2DConv2D&DenseNet/T2_CF_ReLu/Relu:activations:03DenseNet/T2_CF_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:��������� *
paddingVALID*
strides
�
DenseNet/T2_CF_Dropout/IdentityIdentity%DenseNet/T2_CF_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:��������� �
(DenseNet/tf.compat.v1.pad_1/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
DenseNet/tf.compat.v1.pad_1/PadPad(DenseNet/T2_CF_Dropout/Identity:output:01DenseNet/tf.compat.v1.pad_1/Pad/paddings:output:0*
T0*/
_output_shapes
:��������� �
DenseNet/T2_Pool/AvgPoolAvgPool(DenseNet/tf.compat.v1.pad_1/Pad:output:0*
T0*/
_output_shapes
:��������� *
ksize
*
paddingVALID*
strides
�
(DenseNet/B3_CF1_BatchNorm/ReadVariableOpReadVariableOp1densenet_b3_cf1_batchnorm_readvariableop_resource*
_output_shapes
: *
dtype0�
9DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b3_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
;DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b3_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
*DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3FusedBatchNormV3!DenseNet/T2_Pool/AvgPool:output:0densenet_b3_cf1_batchnorm_scale0DenseNet/B3_CF1_BatchNorm/ReadVariableOp:value:0ADenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:��������� : : : : :*
epsilon%o�:*
is_training( �
DenseNet/B3_CF1_ReLu/ReluRelu.DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:��������� �
,DenseNet/B3_CF1_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b3_cf1_conv2d_conv2d_readvariableop_resource*&
_output_shapes
: *
dtype0�
DenseNet/B3_CF1_Conv2D/Conv2DConv2D'DenseNet/B3_CF1_ReLu/Relu:activations:04DenseNet/B3_CF1_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
�
 DenseNet/B3_CF1_Dropout/IdentityIdentity&DenseNet/B3_CF1_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:����������
(DenseNet/B3_CF2_BatchNorm/ReadVariableOpReadVariableOp1densenet_b3_cf2_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
9DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b3_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
;DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b3_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
*DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3FusedBatchNormV3)DenseNet/B3_CF1_Dropout/Identity:output:0densenet_b3_cf2_batchnorm_scale0DenseNet/B3_CF2_BatchNorm/ReadVariableOp:value:0ADenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( �
DenseNet/B3_CF2_ReLu/ReluRelu.DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:����������
,DenseNet/B3_CF2_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b3_cf2_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/B3_CF2_Conv2D/Conv2DConv2D'DenseNet/B3_CF2_ReLu/Relu:activations:04DenseNet/B3_CF2_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
�
 DenseNet/B3_CF2_Dropout/IdentityIdentity&DenseNet/B3_CF2_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������`
DenseNet/B3_Concat/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
DenseNet/B3_Concat/concatConcatV2!DenseNet/T2_Pool/AvgPool:output:0)DenseNet/B3_CF1_Dropout/Identity:output:0)DenseNet/B3_CF2_Dropout/Identity:output:0'DenseNet/B3_Concat/concat/axis:output:0*
N*
T0*/
_output_shapes
:���������(�
'DenseNet/T3_CF_BatchNorm/ReadVariableOpReadVariableOp0densenet_t3_cf_batchnorm_readvariableop_resource*
_output_shapes
:(*
dtype0�
8DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpAdensenet_t3_cf_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
:DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpCdensenet_t3_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
)DenseNet/T3_CF_BatchNorm/FusedBatchNormV3FusedBatchNormV3"DenseNet/B3_Concat/concat:output:0densenet_t3_cf_batchnorm_scale/DenseNet/T3_CF_BatchNorm/ReadVariableOp:value:0@DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0BDenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������(:(:(:(:(:*
epsilon%o�:*
is_training( �
DenseNet/T3_CF_ReLu/ReluRelu-DenseNet/T3_CF_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������(�
+DenseNet/T3_CF_Conv2D/Conv2D/ReadVariableOpReadVariableOp4densenet_t3_cf_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:((*
dtype0�
DenseNet/T3_CF_Conv2D/Conv2DConv2D&DenseNet/T3_CF_ReLu/Relu:activations:03DenseNet/T3_CF_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������(*
paddingVALID*
strides
�
DenseNet/T3_CF_Dropout/IdentityIdentity%DenseNet/T3_CF_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������(�
(DenseNet/tf.compat.v1.pad_2/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
DenseNet/tf.compat.v1.pad_2/PadPad(DenseNet/T3_CF_Dropout/Identity:output:01DenseNet/tf.compat.v1.pad_2/Pad/paddings:output:0*
T0*/
_output_shapes
:���������	(�
DenseNet/T3_Pool/AvgPoolAvgPool(DenseNet/tf.compat.v1.pad_2/Pad:output:0*
T0*/
_output_shapes
:���������(*
ksize
*
paddingVALID*
strides
�
(DenseNet/B4_CF1_BatchNorm/ReadVariableOpReadVariableOp1densenet_b4_cf1_batchnorm_readvariableop_resource*
_output_shapes
:(*
dtype0�
9DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b4_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
;DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b4_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
*DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3FusedBatchNormV3!DenseNet/T3_Pool/AvgPool:output:0densenet_b4_cf1_batchnorm_scale0DenseNet/B4_CF1_BatchNorm/ReadVariableOp:value:0ADenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������(:(:(:(:(:*
epsilon%o�:*
is_training( �
DenseNet/B4_CF1_ReLu/ReluRelu.DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������(�
,DenseNet/B4_CF1_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b4_cf1_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:(*
dtype0�
DenseNet/B4_CF1_Conv2D/Conv2DConv2D'DenseNet/B4_CF1_ReLu/Relu:activations:04DenseNet/B4_CF1_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
�
 DenseNet/B4_CF1_Dropout/IdentityIdentity&DenseNet/B4_CF1_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������`
DenseNet/B4_Concat/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
DenseNet/B4_Concat/concatConcatV2!DenseNet/T3_Pool/AvgPool:output:0)DenseNet/B4_CF1_Dropout/Identity:output:0'DenseNet/B4_Concat/concat/axis:output:0*
N*
T0*/
_output_shapes
:���������,�
+DenseNet/batch_normalization/ReadVariableOpReadVariableOp4densenet_batch_normalization_readvariableop_resource*
_output_shapes
:,*
dtype0�
<DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOpReadVariableOpEdensenet_batch_normalization_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:,*
dtype0�
>DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpGdensenet_batch_normalization_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:,*
dtype0�
-DenseNet/batch_normalization/FusedBatchNormV3FusedBatchNormV3"DenseNet/B4_Concat/concat:output:0"densenet_batch_normalization_scale3DenseNet/batch_normalization/ReadVariableOp:value:0DDenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp:value:0FDenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������,:,:,:,:,:*
epsilon%��'7*
is_training( �
DenseNet/ReLu/ReluRelu1DenseNet/batch_normalization/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������,�
8DenseNet/global_average_pooling2d/Mean/reduction_indicesConst*
_output_shapes
:*
dtype0*
valueB"      �
&DenseNet/global_average_pooling2d/MeanMean DenseNet/ReLu/Relu:activations:0ADenseNet/global_average_pooling2d/Mean/reduction_indices:output:0*
T0*'
_output_shapes
:���������,�
$DenseNet/FC-D1/MatMul/ReadVariableOpReadVariableOp-densenet_fc_d1_matmul_readvariableop_resource*
_output_shapes

:,*
dtype0�
DenseNet/FC-D1/MatMulMatMul/DenseNet/global_average_pooling2d/Mean:output:0,DenseNet/FC-D1/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:����������
.DenseNet/BatchNorm-D1/batchnorm/ReadVariableOpReadVariableOp7densenet_batchnorm_d1_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0j
%DenseNet/BatchNorm-D1/batchnorm/add/yConst*
_output_shapes
: *
dtype0*
valueB
 *w�+2�
#DenseNet/BatchNorm-D1/batchnorm/addAddV26DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp:value:0.DenseNet/BatchNorm-D1/batchnorm/add/y:output:0*
T0*
_output_shapes
:|
%DenseNet/BatchNorm-D1/batchnorm/RsqrtRsqrt'DenseNet/BatchNorm-D1/batchnorm/add:z:0*
T0*
_output_shapes
:�
#DenseNet/BatchNorm-D1/batchnorm/mulMulDenseNet/FC-D1/MatMul:product:0)DenseNet/BatchNorm-D1/batchnorm/Rsqrt:y:0*
T0*'
_output_shapes
:����������
0DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_1ReadVariableOp9densenet_batchnorm_d1_batchnorm_readvariableop_1_resource*
_output_shapes
:*
dtype0�
%DenseNet/BatchNorm-D1/batchnorm/mul_1Mul8DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_1:value:0)DenseNet/BatchNorm-D1/batchnorm/Rsqrt:y:0*
T0*
_output_shapes
:�
0DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_2ReadVariableOp9densenet_batchnorm_d1_batchnorm_readvariableop_2_resource*
_output_shapes
:*
dtype0�
#DenseNet/BatchNorm-D1/batchnorm/subSub8DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_2:value:0)DenseNet/BatchNorm-D1/batchnorm/mul_1:z:0*
T0*
_output_shapes
:�
%DenseNet/BatchNorm-D1/batchnorm/add_1AddV2'DenseNet/BatchNorm-D1/batchnorm/mul:z:0'DenseNet/BatchNorm-D1/batchnorm/sub:z:0*
T0*'
_output_shapes
:����������
%DenseNet/Logits/MatMul/ReadVariableOpReadVariableOp.densenet_logits_matmul_readvariableop_resource*
_output_shapes

:*
dtype0�
DenseNet/Logits/MatMulMatMul)DenseNet/BatchNorm-D1/batchnorm/add_1:z:0-DenseNet/Logits/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:����������
&DenseNet/Logits/BiasAdd/ReadVariableOpReadVariableOp/densenet_logits_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0�
DenseNet/Logits/BiasAddBiasAdd DenseNet/Logits/MatMul:product:0.DenseNet/Logits/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������v
DenseNet/Logits/SigmoidSigmoid DenseNet/Logits/BiasAdd:output:0*
T0*'
_output_shapes
:���������j
IdentityIdentityDenseNet/Logits/Sigmoid:y:0^NoOp*
T0*'
_output_shapes
:����������
NoOpNoOp:^DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B1_CF1_BatchNorm/ReadVariableOp-^DenseNet/B1_CF1_Conv2D/Conv2D/ReadVariableOp:^DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B1_CF2_BatchNorm/ReadVariableOp-^DenseNet/B1_CF2_Conv2D/Conv2D/ReadVariableOp:^DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B2_CF1_BatchNorm/ReadVariableOp-^DenseNet/B2_CF1_Conv2D/Conv2D/ReadVariableOp:^DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B2_CF2_BatchNorm/ReadVariableOp-^DenseNet/B2_CF2_Conv2D/Conv2D/ReadVariableOp:^DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B3_CF1_BatchNorm/ReadVariableOp-^DenseNet/B3_CF1_Conv2D/Conv2D/ReadVariableOp:^DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B3_CF2_BatchNorm/ReadVariableOp-^DenseNet/B3_CF2_Conv2D/Conv2D/ReadVariableOp:^DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B4_CF1_BatchNorm/ReadVariableOp-^DenseNet/B4_CF1_Conv2D/Conv2D/ReadVariableOp/^DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp1^DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_11^DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_2%^DenseNet/FC-D1/MatMul/ReadVariableOp'^DenseNet/Logits/BiasAdd/ReadVariableOp&^DenseNet/Logits/MatMul/ReadVariableOp(^DenseNet/Pre_Conv/Conv2D/ReadVariableOp9^DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp;^DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1(^DenseNet/T1_CF_BatchNorm/ReadVariableOp,^DenseNet/T1_CF_Conv2D/Conv2D/ReadVariableOp9^DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp;^DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1(^DenseNet/T2_CF_BatchNorm/ReadVariableOp,^DenseNet/T2_CF_Conv2D/Conv2D/ReadVariableOp9^DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp;^DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1(^DenseNet/T3_CF_BatchNorm/ReadVariableOp,^DenseNet/T3_CF_Conv2D/Conv2D/ReadVariableOp=^DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp?^DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp_1,^DenseNet/batch_normalization/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*�
_input_shapes�
�:���������-C: :: : : : :: : : : :: : : : :: : : : :: : : : : : : : : : : : : : :: : : : :(: : : : :(: : : : :,: : : : : : : : : 2v
9DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B1_CF1_BatchNorm/ReadVariableOp(DenseNet/B1_CF1_BatchNorm/ReadVariableOp2\
,DenseNet/B1_CF1_Conv2D/Conv2D/ReadVariableOp,DenseNet/B1_CF1_Conv2D/Conv2D/ReadVariableOp2v
9DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B1_CF2_BatchNorm/ReadVariableOp(DenseNet/B1_CF2_BatchNorm/ReadVariableOp2\
,DenseNet/B1_CF2_Conv2D/Conv2D/ReadVariableOp,DenseNet/B1_CF2_Conv2D/Conv2D/ReadVariableOp2v
9DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B2_CF1_BatchNorm/ReadVariableOp(DenseNet/B2_CF1_BatchNorm/ReadVariableOp2\
,DenseNet/B2_CF1_Conv2D/Conv2D/ReadVariableOp,DenseNet/B2_CF1_Conv2D/Conv2D/ReadVariableOp2v
9DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B2_CF2_BatchNorm/ReadVariableOp(DenseNet/B2_CF2_BatchNorm/ReadVariableOp2\
,DenseNet/B2_CF2_Conv2D/Conv2D/ReadVariableOp,DenseNet/B2_CF2_Conv2D/Conv2D/ReadVariableOp2v
9DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B3_CF1_BatchNorm/ReadVariableOp(DenseNet/B3_CF1_BatchNorm/ReadVariableOp2\
,DenseNet/B3_CF1_Conv2D/Conv2D/ReadVariableOp,DenseNet/B3_CF1_Conv2D/Conv2D/ReadVariableOp2v
9DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B3_CF2_BatchNorm/ReadVariableOp(DenseNet/B3_CF2_BatchNorm/ReadVariableOp2\
,DenseNet/B3_CF2_Conv2D/Conv2D/ReadVariableOp,DenseNet/B3_CF2_Conv2D/Conv2D/ReadVariableOp2v
9DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B4_CF1_BatchNorm/ReadVariableOp(DenseNet/B4_CF1_BatchNorm/ReadVariableOp2\
,DenseNet/B4_CF1_Conv2D/Conv2D/ReadVariableOp,DenseNet/B4_CF1_Conv2D/Conv2D/ReadVariableOp2`
.DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp.DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp2d
0DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_10DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_12d
0DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_20DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_22L
$DenseNet/FC-D1/MatMul/ReadVariableOp$DenseNet/FC-D1/MatMul/ReadVariableOp2P
&DenseNet/Logits/BiasAdd/ReadVariableOp&DenseNet/Logits/BiasAdd/ReadVariableOp2N
%DenseNet/Logits/MatMul/ReadVariableOp%DenseNet/Logits/MatMul/ReadVariableOp2R
'DenseNet/Pre_Conv/Conv2D/ReadVariableOp'DenseNet/Pre_Conv/Conv2D/ReadVariableOp2t
8DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp8DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2x
:DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_12R
'DenseNet/T1_CF_BatchNorm/ReadVariableOp'DenseNet/T1_CF_BatchNorm/ReadVariableOp2Z
+DenseNet/T1_CF_Conv2D/Conv2D/ReadVariableOp+DenseNet/T1_CF_Conv2D/Conv2D/ReadVariableOp2t
8DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp8DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2x
:DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_12R
'DenseNet/T2_CF_BatchNorm/ReadVariableOp'DenseNet/T2_CF_BatchNorm/ReadVariableOp2Z
+DenseNet/T2_CF_Conv2D/Conv2D/ReadVariableOp+DenseNet/T2_CF_Conv2D/Conv2D/ReadVariableOp2t
8DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp8DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2x
:DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_12R
'DenseNet/T3_CF_BatchNorm/ReadVariableOp'DenseNet/T3_CF_BatchNorm/ReadVariableOp2Z
+DenseNet/T3_CF_Conv2D/Conv2D/ReadVariableOp+DenseNet/T3_CF_Conv2D/Conv2D/ReadVariableOp2|
<DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp<DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp2�
>DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp_1>DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp_12Z
+DenseNet/batch_normalization/ReadVariableOp+DenseNet/batch_normalization/ReadVariableOp:S O
+
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
: :  

_output_shapes
: : %

_output_shapes
:: *

_output_shapes
:(: /

_output_shapes
:(: 4

_output_shapes
:,
�
D
(__inference_rescaling_layer_call_fn_6205

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_rescaling_layer_call_and_return_conditional_losses_2711h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
f
H__inference_B1_CF1_Dropout_layer_call_and_return_conditional_losses_2773

inputs

identity_1V
IdentityIdentityinputs*
T0*/
_output_shapes
:���������-Cc

Identity_1IdentityIdentity:output:0*
T0*/
_output_shapes
:���������-C"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
�
F__inference_BatchNorm-D1_layer_call_and_return_conditional_losses_2685

inputs/
!batchnorm_readvariableop_resource:1
#batchnorm_readvariableop_1_resource:1
#batchnorm_readvariableop_2_resource:
identity��batchnorm/ReadVariableOp�batchnorm/ReadVariableOp_1�batchnorm/ReadVariableOp_2v
batchnorm/ReadVariableOpReadVariableOp!batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0T
batchnorm/add/yConst*
_output_shapes
: *
dtype0*
valueB
 *w�+2w
batchnorm/addAddV2 batchnorm/ReadVariableOp:value:0batchnorm/add/y:output:0*
T0*
_output_shapes
:P
batchnorm/RsqrtRsqrtbatchnorm/add:z:0*
T0*
_output_shapes
:c
batchnorm/mulMulinputsbatchnorm/Rsqrt:y:0*
T0*'
_output_shapes
:���������z
batchnorm/ReadVariableOp_1ReadVariableOp#batchnorm_readvariableop_1_resource*
_output_shapes
:*
dtype0t
batchnorm/mul_1Mul"batchnorm/ReadVariableOp_1:value:0batchnorm/Rsqrt:y:0*
T0*
_output_shapes
:z
batchnorm/ReadVariableOp_2ReadVariableOp#batchnorm_readvariableop_2_resource*
_output_shapes
:*
dtype0r
batchnorm/subSub"batchnorm/ReadVariableOp_2:value:0batchnorm/mul_1:z:0*
T0*
_output_shapes
:p
batchnorm/add_1AddV2batchnorm/mul:z:0batchnorm/sub:z:0*
T0*'
_output_shapes
:���������b
IdentityIdentitybatchnorm/add_1:z:0^NoOp*
T0*'
_output_shapes
:����������
NoOpNoOp^batchnorm/ReadVariableOp^batchnorm/ReadVariableOp_1^batchnorm/ReadVariableOp_2*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*,
_input_shapes
:���������: : : 24
batchnorm/ReadVariableOpbatchnorm/ReadVariableOp28
batchnorm/ReadVariableOp_1batchnorm/ReadVariableOp_128
batchnorm/ReadVariableOp_2batchnorm/ReadVariableOp_2:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
M__inference_batch_normalization_layer_call_and_return_conditional_losses_3313

inputs	
scale%
readvariableop_resource:,6
(fusedbatchnormv3_readvariableop_resource:,8
*fusedbatchnormv3_readvariableop_1_resource:,
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:,*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:,*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:,*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������,:,:,:,:,:*
epsilon%��'7*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������,�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������,:,: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������,
 
_user_specified_nameinputs: 

_output_shapes
:,
�	
�
.__inference_T2_CF_BatchNorm_layer_call_fn_7158

inputs
unknown
	unknown_0: 
	unknown_1: 
	unknown_2: 
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+��������������������������� *%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_2278�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+��������������������������� `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+��������������������������� : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+��������������������������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
�
,__inference_B1_CF1_Conv2D_layer_call_fn_6364

inputs!
unknown:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B1_CF1_Conv2D_layer_call_and_return_conditional_losses_2764w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������-C`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������-C: 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
�
F__inference_T3_CF_Conv2D_layer_call_and_return_conditional_losses_3218

inputs8
conv2d_readvariableop_resource:((
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
:((*
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������(*
paddingVALID*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:���������(^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������(: 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs
�
{
C__inference_B1_Concat_layer_call_and_return_conditional_losses_2834

inputs
inputs_1
inputs_2
identityM
concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
concatConcatV2inputsinputs_1inputs_2concat/axis:output:0*
N*
T0*/
_output_shapes
:���������-C_
IdentityIdentityconcat:output:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*d
_input_shapesS
Q:���������-C:���������-C:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs:WS
/
_output_shapes
:���������-C
 
_user_specified_nameinputs:WS
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
�
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_3133

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:����������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs: 

_output_shapes
:
�
`
D__inference_T2_CF_ReLu_layer_call_and_return_conditional_losses_3038

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:��������� b
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:��������� "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:��������� :W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
�	
�
/__inference_B2_CF2_BatchNorm_layer_call_fn_6959

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+���������������������������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_2186�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_6501

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������-C�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������-C:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:
�
a
E__inference_B1_CF2_ReLu_layer_call_and_return_conditional_losses_6528

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:���������-Cb
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
�
G__inference_B3_CF2_Conv2D_layer_call_and_return_conditional_losses_3157

inputs8
conv2d_readvariableop_resource:
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:���������^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������: 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_4152

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:����������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs: 

_output_shapes
:
�	
�
/__inference_B1_CF1_BatchNorm_layer_call_fn_6240

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+���������������������������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_1926�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_2080

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
H
,__inference_T2_CF_Dropout_layer_call_fn_7281

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_T2_CF_Dropout_layer_call_and_return_conditional_losses_3056h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:��������� "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:��������� :W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
�
�
M__inference_batch_normalization_layer_call_and_return_conditional_losses_8141

inputs	
scale%
readvariableop_resource:,6
(fusedbatchnormv3_readvariableop_resource:,8
*fusedbatchnormv3_readvariableop_1_resource:,
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:,*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:,*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:,*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������,:,:,:,:,:*
epsilon%��'7*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������,�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������,:,: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������,
 
_user_specified_nameinputs: 

_output_shapes
:,
�
]
A__inference_T1_Pool_layer_call_and_return_conditional_losses_6770

inputs
identity�
AvgPoolAvgPoolinputs*
T0*J
_output_shapes8
6:4������������������������������������*
ksize
*
paddingVALID*
strides
{
IdentityIdentityAvgPool:output:0*
T0*J
_output_shapes8
6:4������������������������������������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*I
_input_shapes8
6:4������������������������������������:r n
J
_output_shapes8
6:4������������������������������������
 
_user_specified_nameinputs
�
�
,__inference_B3_CF1_Conv2D_layer_call_fn_7460

inputs!
unknown: 
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B3_CF1_Conv2D_layer_call_and_return_conditional_losses_3106w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:��������� : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
�
�
.__inference_T2_CF_BatchNorm_layer_call_fn_7171

inputs
unknown
	unknown_0: 
	unknown_1: 
	unknown_2: 
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� *%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_3023w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:��������� `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':��������� : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
b
(__inference_B2_Concat_layer_call_fn_7124
inputs_0
inputs_1
inputs_2
identity�
PartitionedCallPartitionedCallinputs_0inputs_1inputs_2*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_B2_Concat_layer_call_and_return_conditional_losses_3005h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:��������� "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*d
_input_shapesS
Q:���������:���������:���������:Y U
/
_output_shapes
:���������
"
_user_specified_name
inputs/0:YU
/
_output_shapes
:���������
"
_user_specified_name
inputs/1:YU
/
_output_shapes
:���������
"
_user_specified_name
inputs/2
�
�
G__inference_B1_CF2_Conv2D_layer_call_and_return_conditional_losses_2815

inputs8
conv2d_readvariableop_resource:
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:���������-C^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������-C: 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
�
'__inference_DenseNet_layer_call_fn_5632

inputs!
unknown:
	unknown_0
	unknown_1:
	unknown_2:
	unknown_3:#
	unknown_4:
	unknown_5
	unknown_6:
	unknown_7:
	unknown_8:#
	unknown_9:

unknown_10

unknown_11:

unknown_12:

unknown_13:$

unknown_14:

unknown_15

unknown_16:

unknown_17:

unknown_18:$

unknown_19:

unknown_20

unknown_21:

unknown_22:

unknown_23:$

unknown_24:

unknown_25

unknown_26: 

unknown_27: 

unknown_28: $

unknown_29:  

unknown_30

unknown_31: 

unknown_32: 

unknown_33: $

unknown_34: 

unknown_35

unknown_36:

unknown_37:

unknown_38:$

unknown_39:

unknown_40

unknown_41:(

unknown_42:(

unknown_43:($

unknown_44:((

unknown_45

unknown_46:(

unknown_47:(

unknown_48:($

unknown_49:(

unknown_50

unknown_51:,

unknown_52:,

unknown_53:,

unknown_54:,

unknown_55:

unknown_56:

unknown_57:

unknown_58:

unknown_59:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4	unknown_5	unknown_6	unknown_7	unknown_8	unknown_9
unknown_10
unknown_11
unknown_12
unknown_13
unknown_14
unknown_15
unknown_16
unknown_17
unknown_18
unknown_19
unknown_20
unknown_21
unknown_22
unknown_23
unknown_24
unknown_25
unknown_26
unknown_27
unknown_28
unknown_29
unknown_30
unknown_31
unknown_32
unknown_33
unknown_34
unknown_35
unknown_36
unknown_37
unknown_38
unknown_39
unknown_40
unknown_41
unknown_42
unknown_43
unknown_44
unknown_45
unknown_46
unknown_47
unknown_48
unknown_49
unknown_50
unknown_51
unknown_52
unknown_53
unknown_54
unknown_55
unknown_56
unknown_57
unknown_58
unknown_59*I
TinB
@2>*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*T
_read_only_resource_inputs6
42	
!"#$&'()+,-.012356789:;<=*-
config_proto

CPU

GPU 2J 8� *K
fFRD
B__inference_DenseNet_layer_call_and_return_conditional_losses_4748o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*�
_input_shapes�
�:���������-C: :: : : : :: : : : :: : : : :: : : : :: : : : : : : : : : : : : : :: : : : :(: : : : :(: : : : :,: : : : : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:S O
+
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
: :  

_output_shapes
: : %

_output_shapes
:: *

_output_shapes
:(: /

_output_shapes
:(: 4

_output_shapes
:,
�
a
E__inference_B2_CF2_ReLu_layer_call_and_return_conditional_losses_7076

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:���������b
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
I
-__inference_B1_CF1_Dropout_layer_call_fn_6376

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B1_CF1_Dropout_layer_call_and_return_conditional_losses_2773h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�

�
@__inference_Logits_layer_call_and_return_conditional_losses_8297

inputs0
matmul_readvariableop_resource:-
biasadd_readvariableop_resource:
identity��BiasAdd/ReadVariableOp�MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0v
BiasAddBiasAddMatMul:product:0BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������V
SigmoidSigmoidBiasAdd:output:0*
T0*'
_output_shapes
:���������Z
IdentityIdentitySigmoid:y:0^NoOp*
T0*'
_output_shapes
:���������w
NoOpNoOp^BiasAdd/ReadVariableOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:���������: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�
]
A__inference_T3_Pool_layer_call_and_return_conditional_losses_2496

inputs
identity�
AvgPoolAvgPoolinputs*
T0*J
_output_shapes8
6:4������������������������������������*
ksize
*
paddingVALID*
strides
{
IdentityIdentityAvgPool:output:0*
T0*J
_output_shapes8
6:4������������������������������������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*I
_input_shapes8
6:4������������������������������������:r n
J
_output_shapes8
6:4������������������������������������
 
_user_specified_nameinputs
�
]
A__inference_T1_Pool_layer_call_and_return_conditional_losses_2100

inputs
identity�
AvgPoolAvgPoolinputs*
T0*J
_output_shapes8
6:4������������������������������������*
ksize
*
paddingVALID*
strides
{
IdentityIdentityAvgPool:output:0*
T0*J
_output_shapes8
6:4������������������������������������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*I
_input_shapes8
6:4������������������������������������:r n
J
_output_shapes8
6:4������������������������������������
 
_user_specified_nameinputs
�
f
H__inference_B4_CF1_Dropout_layer_call_and_return_conditional_losses_8030

inputs

identity_1V
IdentityIdentityinputs*
T0*/
_output_shapes
:���������c

Identity_1IdentityIdentity:output:0*
T0*/
_output_shapes
:���������"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
B
&__inference_T2_Pool_layer_call_fn_7308

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *J
_output_shapes8
6:4������������������������������������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *J
fERC
A__inference_T2_Pool_layer_call_and_return_conditional_losses_2298�
IdentityIdentityPartitionedCall:output:0*
T0*J
_output_shapes8
6:4������������������������������������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*I
_input_shapes8
6:4������������������������������������:r n
J
_output_shapes8
6:4������������������������������������
 
_user_specified_nameinputs
�
�
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_7049

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:����������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
,__inference_B1_CF2_Conv2D_layer_call_fn_6535

inputs!
unknown:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B1_CF2_Conv2D_layer_call_and_return_conditional_losses_2815w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������-C`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������-C: 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
ހ
�
B__inference_DenseNet_layer_call_and_return_conditional_losses_4748

inputs'
pre_conv_4565:
b1_cf1_batchnorm_4568#
b1_cf1_batchnorm_4570:#
b1_cf1_batchnorm_4572:#
b1_cf1_batchnorm_4574:,
b1_cf1_conv2d_4578:
b1_cf2_batchnorm_4582#
b1_cf2_batchnorm_4584:#
b1_cf2_batchnorm_4586:#
b1_cf2_batchnorm_4588:,
b1_cf2_conv2d_4592:
t1_cf_batchnorm_4597"
t1_cf_batchnorm_4599:"
t1_cf_batchnorm_4601:"
t1_cf_batchnorm_4603:+
t1_cf_conv2d_4607:
b2_cf1_batchnorm_4614#
b2_cf1_batchnorm_4616:#
b2_cf1_batchnorm_4618:#
b2_cf1_batchnorm_4620:,
b2_cf1_conv2d_4624:
b2_cf2_batchnorm_4628#
b2_cf2_batchnorm_4630:#
b2_cf2_batchnorm_4632:#
b2_cf2_batchnorm_4634:,
b2_cf2_conv2d_4638:
t2_cf_batchnorm_4643"
t2_cf_batchnorm_4645: "
t2_cf_batchnorm_4647: "
t2_cf_batchnorm_4649: +
t2_cf_conv2d_4653:  
b3_cf1_batchnorm_4660#
b3_cf1_batchnorm_4662: #
b3_cf1_batchnorm_4664: #
b3_cf1_batchnorm_4666: ,
b3_cf1_conv2d_4670: 
b3_cf2_batchnorm_4674#
b3_cf2_batchnorm_4676:#
b3_cf2_batchnorm_4678:#
b3_cf2_batchnorm_4680:,
b3_cf2_conv2d_4684:
t3_cf_batchnorm_4689"
t3_cf_batchnorm_4691:("
t3_cf_batchnorm_4693:("
t3_cf_batchnorm_4695:(+
t3_cf_conv2d_4699:((
b4_cf1_batchnorm_4706#
b4_cf1_batchnorm_4708:(#
b4_cf1_batchnorm_4710:(#
b4_cf1_batchnorm_4712:(,
b4_cf1_conv2d_4716:(
batch_normalization_4721&
batch_normalization_4723:,&
batch_normalization_4725:,&
batch_normalization_4727:,

fc_d1_4732:,
batchnorm_d1_4735:
batchnorm_d1_4737:
batchnorm_d1_4739:
logits_4742:
logits_4744:
identity��(B1_CF1_BatchNorm/StatefulPartitionedCall�%B1_CF1_Conv2D/StatefulPartitionedCall�&B1_CF1_Dropout/StatefulPartitionedCall�(B1_CF2_BatchNorm/StatefulPartitionedCall�%B1_CF2_Conv2D/StatefulPartitionedCall�&B1_CF2_Dropout/StatefulPartitionedCall�(B2_CF1_BatchNorm/StatefulPartitionedCall�%B2_CF1_Conv2D/StatefulPartitionedCall�&B2_CF1_Dropout/StatefulPartitionedCall�(B2_CF2_BatchNorm/StatefulPartitionedCall�%B2_CF2_Conv2D/StatefulPartitionedCall�&B2_CF2_Dropout/StatefulPartitionedCall�(B3_CF1_BatchNorm/StatefulPartitionedCall�%B3_CF1_Conv2D/StatefulPartitionedCall�&B3_CF1_Dropout/StatefulPartitionedCall�(B3_CF2_BatchNorm/StatefulPartitionedCall�%B3_CF2_Conv2D/StatefulPartitionedCall�&B3_CF2_Dropout/StatefulPartitionedCall�(B4_CF1_BatchNorm/StatefulPartitionedCall�%B4_CF1_Conv2D/StatefulPartitionedCall�&B4_CF1_Dropout/StatefulPartitionedCall�$BatchNorm-D1/StatefulPartitionedCall�FC-D1/StatefulPartitionedCall�Logits/StatefulPartitionedCall� Pre_Conv/StatefulPartitionedCall�'T1_CF_BatchNorm/StatefulPartitionedCall�$T1_CF_Conv2D/StatefulPartitionedCall�%T1_CF_Dropout/StatefulPartitionedCall�'T2_CF_BatchNorm/StatefulPartitionedCall�$T2_CF_Conv2D/StatefulPartitionedCall�%T2_CF_Dropout/StatefulPartitionedCall�'T3_CF_BatchNorm/StatefulPartitionedCall�$T3_CF_Conv2D/StatefulPartitionedCall�%T3_CF_Dropout/StatefulPartitionedCall�+batch_normalization/StatefulPartitionedCall_
tf.expand_dims/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B :�
tf.expand_dims/ExpandDims
ExpandDimsinputs&tf.expand_dims/ExpandDims/dim:output:0*
T0*/
_output_shapes
:���������-C�
rescaling/PartitionedCallPartitionedCall"tf.expand_dims/ExpandDims:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_rescaling_layer_call_and_return_conditional_losses_2711�
 Pre_Conv/StatefulPartitionedCallStatefulPartitionedCall"rescaling/PartitionedCall:output:0pre_conv_4565*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *K
fFRD
B__inference_Pre_Conv_layer_call_and_return_conditional_losses_2720�
(B1_CF1_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall)Pre_Conv/StatefulPartitionedCall:output:0b1_cf1_batchnorm_4568b1_cf1_batchnorm_4570b1_cf1_batchnorm_4572b1_cf1_batchnorm_4574*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_4405�
B1_CF1_ReLu/PartitionedCallPartitionedCall1B1_CF1_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B1_CF1_ReLu_layer_call_and_return_conditional_losses_2755�
%B1_CF1_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B1_CF1_ReLu/PartitionedCall:output:0b1_cf1_conv2d_4578*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B1_CF1_Conv2D_layer_call_and_return_conditional_losses_2764�
&B1_CF1_Dropout/StatefulPartitionedCallStatefulPartitionedCall.B1_CF1_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B1_CF1_Dropout_layer_call_and_return_conditional_losses_4356�
(B1_CF2_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall/B1_CF1_Dropout/StatefulPartitionedCall:output:0b1_cf2_batchnorm_4582b1_cf2_batchnorm_4584b1_cf2_batchnorm_4586b1_cf2_batchnorm_4588*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_4325�
B1_CF2_ReLu/PartitionedCallPartitionedCall1B1_CF2_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B1_CF2_ReLu_layer_call_and_return_conditional_losses_2806�
%B1_CF2_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B1_CF2_ReLu/PartitionedCall:output:0b1_cf2_conv2d_4592*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B1_CF2_Conv2D_layer_call_and_return_conditional_losses_2815�
&B1_CF2_Dropout/StatefulPartitionedCallStatefulPartitionedCall.B1_CF2_Conv2D/StatefulPartitionedCall:output:0'^B1_CF1_Dropout/StatefulPartitionedCall*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B1_CF2_Dropout_layer_call_and_return_conditional_losses_4276�
B1_Concat/PartitionedCallPartitionedCall)Pre_Conv/StatefulPartitionedCall:output:0/B1_CF1_Dropout/StatefulPartitionedCall:output:0/B1_CF2_Dropout/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_B1_Concat_layer_call_and_return_conditional_losses_2834�
'T1_CF_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall"B1_Concat/PartitionedCall:output:0t1_cf_batchnorm_4597t1_cf_batchnorm_4599t1_cf_batchnorm_4601t1_cf_batchnorm_4603*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_4237�
T1_CF_ReLu/PartitionedCallPartitionedCall0T1_CF_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *M
fHRF
D__inference_T1_CF_ReLu_layer_call_and_return_conditional_losses_2867�
$T1_CF_Conv2D/StatefulPartitionedCallStatefulPartitionedCall#T1_CF_ReLu/PartitionedCall:output:0t1_cf_conv2d_4607*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_T1_CF_Conv2D_layer_call_and_return_conditional_losses_2876�
%T1_CF_Dropout/StatefulPartitionedCallStatefulPartitionedCall-T1_CF_Conv2D/StatefulPartitionedCall:output:0'^B1_CF2_Dropout/StatefulPartitionedCall*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_T1_CF_Dropout_layer_call_and_return_conditional_losses_4188�
tf.compat.v1.pad/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
tf.compat.v1.pad/PadPad.T1_CF_Dropout/StatefulPartitionedCall:output:0&tf.compat.v1.pad/Pad/paddings:output:0*
T0*/
_output_shapes
:���������-E�
T1_Pool/PartitionedCallPartitionedCalltf.compat.v1.pad/Pad:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *J
fERC
A__inference_T1_Pool_layer_call_and_return_conditional_losses_2893�
(B2_CF1_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall T1_Pool/PartitionedCall:output:0b2_cf1_batchnorm_4614b2_cf1_batchnorm_4616b2_cf1_batchnorm_4618b2_cf1_batchnorm_4620*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_4152�
B2_CF1_ReLu/PartitionedCallPartitionedCall1B2_CF1_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B2_CF1_ReLu_layer_call_and_return_conditional_losses_2926�
%B2_CF1_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B2_CF1_ReLu/PartitionedCall:output:0b2_cf1_conv2d_4624*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B2_CF1_Conv2D_layer_call_and_return_conditional_losses_2935�
&B2_CF1_Dropout/StatefulPartitionedCallStatefulPartitionedCall.B2_CF1_Conv2D/StatefulPartitionedCall:output:0&^T1_CF_Dropout/StatefulPartitionedCall*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B2_CF1_Dropout_layer_call_and_return_conditional_losses_4103�
(B2_CF2_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall/B2_CF1_Dropout/StatefulPartitionedCall:output:0b2_cf2_batchnorm_4628b2_cf2_batchnorm_4630b2_cf2_batchnorm_4632b2_cf2_batchnorm_4634*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_4072�
B2_CF2_ReLu/PartitionedCallPartitionedCall1B2_CF2_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B2_CF2_ReLu_layer_call_and_return_conditional_losses_2977�
%B2_CF2_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B2_CF2_ReLu/PartitionedCall:output:0b2_cf2_conv2d_4638*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B2_CF2_Conv2D_layer_call_and_return_conditional_losses_2986�
&B2_CF2_Dropout/StatefulPartitionedCallStatefulPartitionedCall.B2_CF2_Conv2D/StatefulPartitionedCall:output:0'^B2_CF1_Dropout/StatefulPartitionedCall*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B2_CF2_Dropout_layer_call_and_return_conditional_losses_4023�
B2_Concat/PartitionedCallPartitionedCall T1_Pool/PartitionedCall:output:0/B2_CF1_Dropout/StatefulPartitionedCall:output:0/B2_CF2_Dropout/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_B2_Concat_layer_call_and_return_conditional_losses_3005�
'T2_CF_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall"B2_Concat/PartitionedCall:output:0t2_cf_batchnorm_4643t2_cf_batchnorm_4645t2_cf_batchnorm_4647t2_cf_batchnorm_4649*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� *%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_3984�
T2_CF_ReLu/PartitionedCallPartitionedCall0T2_CF_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *M
fHRF
D__inference_T2_CF_ReLu_layer_call_and_return_conditional_losses_3038�
$T2_CF_Conv2D/StatefulPartitionedCallStatefulPartitionedCall#T2_CF_ReLu/PartitionedCall:output:0t2_cf_conv2d_4653*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� *#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_T2_CF_Conv2D_layer_call_and_return_conditional_losses_3047�
%T2_CF_Dropout/StatefulPartitionedCallStatefulPartitionedCall-T2_CF_Conv2D/StatefulPartitionedCall:output:0'^B2_CF2_Dropout/StatefulPartitionedCall*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_T2_CF_Dropout_layer_call_and_return_conditional_losses_3935�
tf.compat.v1.pad_1/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
tf.compat.v1.pad_1/PadPad.T2_CF_Dropout/StatefulPartitionedCall:output:0(tf.compat.v1.pad_1/Pad/paddings:output:0*
T0*/
_output_shapes
:��������� �
T2_Pool/PartitionedCallPartitionedCalltf.compat.v1.pad_1/Pad:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *J
fERC
A__inference_T2_Pool_layer_call_and_return_conditional_losses_3064�
(B3_CF1_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall T2_Pool/PartitionedCall:output:0b3_cf1_batchnorm_4660b3_cf1_batchnorm_4662b3_cf1_batchnorm_4664b3_cf1_batchnorm_4666*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� *%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_3899�
B3_CF1_ReLu/PartitionedCallPartitionedCall1B3_CF1_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B3_CF1_ReLu_layer_call_and_return_conditional_losses_3097�
%B3_CF1_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B3_CF1_ReLu/PartitionedCall:output:0b3_cf1_conv2d_4670*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B3_CF1_Conv2D_layer_call_and_return_conditional_losses_3106�
&B3_CF1_Dropout/StatefulPartitionedCallStatefulPartitionedCall.B3_CF1_Conv2D/StatefulPartitionedCall:output:0&^T2_CF_Dropout/StatefulPartitionedCall*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B3_CF1_Dropout_layer_call_and_return_conditional_losses_3850�
(B3_CF2_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall/B3_CF1_Dropout/StatefulPartitionedCall:output:0b3_cf2_batchnorm_4674b3_cf2_batchnorm_4676b3_cf2_batchnorm_4678b3_cf2_batchnorm_4680*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_3819�
B3_CF2_ReLu/PartitionedCallPartitionedCall1B3_CF2_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B3_CF2_ReLu_layer_call_and_return_conditional_losses_3148�
%B3_CF2_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B3_CF2_ReLu/PartitionedCall:output:0b3_cf2_conv2d_4684*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B3_CF2_Conv2D_layer_call_and_return_conditional_losses_3157�
&B3_CF2_Dropout/StatefulPartitionedCallStatefulPartitionedCall.B3_CF2_Conv2D/StatefulPartitionedCall:output:0'^B3_CF1_Dropout/StatefulPartitionedCall*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B3_CF2_Dropout_layer_call_and_return_conditional_losses_3770�
B3_Concat/PartitionedCallPartitionedCall T2_Pool/PartitionedCall:output:0/B3_CF1_Dropout/StatefulPartitionedCall:output:0/B3_CF2_Dropout/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_B3_Concat_layer_call_and_return_conditional_losses_3176�
'T3_CF_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall"B3_Concat/PartitionedCall:output:0t3_cf_batchnorm_4689t3_cf_batchnorm_4691t3_cf_batchnorm_4693t3_cf_batchnorm_4695*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_3731�
T3_CF_ReLu/PartitionedCallPartitionedCall0T3_CF_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *M
fHRF
D__inference_T3_CF_ReLu_layer_call_and_return_conditional_losses_3209�
$T3_CF_Conv2D/StatefulPartitionedCallStatefulPartitionedCall#T3_CF_ReLu/PartitionedCall:output:0t3_cf_conv2d_4699*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_T3_CF_Conv2D_layer_call_and_return_conditional_losses_3218�
%T3_CF_Dropout/StatefulPartitionedCallStatefulPartitionedCall-T3_CF_Conv2D/StatefulPartitionedCall:output:0'^B3_CF2_Dropout/StatefulPartitionedCall*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_T3_CF_Dropout_layer_call_and_return_conditional_losses_3682�
tf.compat.v1.pad_2/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
tf.compat.v1.pad_2/PadPad.T3_CF_Dropout/StatefulPartitionedCall:output:0(tf.compat.v1.pad_2/Pad/paddings:output:0*
T0*/
_output_shapes
:���������	(�
T3_Pool/PartitionedCallPartitionedCalltf.compat.v1.pad_2/Pad:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *J
fERC
A__inference_T3_Pool_layer_call_and_return_conditional_losses_3235�
(B4_CF1_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall T3_Pool/PartitionedCall:output:0b4_cf1_batchnorm_4706b4_cf1_batchnorm_4708b4_cf1_batchnorm_4710b4_cf1_batchnorm_4712*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_3646�
B4_CF1_ReLu/PartitionedCallPartitionedCall1B4_CF1_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B4_CF1_ReLu_layer_call_and_return_conditional_losses_3268�
%B4_CF1_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B4_CF1_ReLu/PartitionedCall:output:0b4_cf1_conv2d_4716*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B4_CF1_Conv2D_layer_call_and_return_conditional_losses_3277�
&B4_CF1_Dropout/StatefulPartitionedCallStatefulPartitionedCall.B4_CF1_Conv2D/StatefulPartitionedCall:output:0&^T3_CF_Dropout/StatefulPartitionedCall*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B4_CF1_Dropout_layer_call_and_return_conditional_losses_3597�
B4_Concat/PartitionedCallPartitionedCall T3_Pool/PartitionedCall:output:0/B4_CF1_Dropout/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������,* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_B4_Concat_layer_call_and_return_conditional_losses_3295�
+batch_normalization/StatefulPartitionedCallStatefulPartitionedCall"B4_Concat/PartitionedCall:output:0batch_normalization_4721batch_normalization_4723batch_normalization_4725batch_normalization_4727*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������,*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *V
fQRO
M__inference_batch_normalization_layer_call_and_return_conditional_losses_3559�
ReLu/PartitionedCallPartitionedCall4batch_normalization/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������,* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *G
fBR@
>__inference_ReLu_layer_call_and_return_conditional_losses_3328�
(global_average_pooling2d/PartitionedCallPartitionedCallReLu/PartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������,* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *[
fVRT
R__inference_global_average_pooling2d_layer_call_and_return_conditional_losses_3335�
FC-D1/StatefulPartitionedCallStatefulPartitionedCall1global_average_pooling2d/PartitionedCall:output:0
fc_d1_4732*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *H
fCRA
?__inference_FC-D1_layer_call_and_return_conditional_losses_3344�
$BatchNorm-D1/StatefulPartitionedCallStatefulPartitionedCall&FC-D1/StatefulPartitionedCall:output:0batchnorm_d1_4735batchnorm_d1_4737batchnorm_d1_4739*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_BatchNorm-D1_layer_call_and_return_conditional_losses_2685�
Logits/StatefulPartitionedCallStatefulPartitionedCall-BatchNorm-D1/StatefulPartitionedCall:output:0logits_4742logits_4744*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *I
fDRB
@__inference_Logits_layer_call_and_return_conditional_losses_3366v
IdentityIdentity'Logits/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:����������
NoOpNoOp)^B1_CF1_BatchNorm/StatefulPartitionedCall&^B1_CF1_Conv2D/StatefulPartitionedCall'^B1_CF1_Dropout/StatefulPartitionedCall)^B1_CF2_BatchNorm/StatefulPartitionedCall&^B1_CF2_Conv2D/StatefulPartitionedCall'^B1_CF2_Dropout/StatefulPartitionedCall)^B2_CF1_BatchNorm/StatefulPartitionedCall&^B2_CF1_Conv2D/StatefulPartitionedCall'^B2_CF1_Dropout/StatefulPartitionedCall)^B2_CF2_BatchNorm/StatefulPartitionedCall&^B2_CF2_Conv2D/StatefulPartitionedCall'^B2_CF2_Dropout/StatefulPartitionedCall)^B3_CF1_BatchNorm/StatefulPartitionedCall&^B3_CF1_Conv2D/StatefulPartitionedCall'^B3_CF1_Dropout/StatefulPartitionedCall)^B3_CF2_BatchNorm/StatefulPartitionedCall&^B3_CF2_Conv2D/StatefulPartitionedCall'^B3_CF2_Dropout/StatefulPartitionedCall)^B4_CF1_BatchNorm/StatefulPartitionedCall&^B4_CF1_Conv2D/StatefulPartitionedCall'^B4_CF1_Dropout/StatefulPartitionedCall%^BatchNorm-D1/StatefulPartitionedCall^FC-D1/StatefulPartitionedCall^Logits/StatefulPartitionedCall!^Pre_Conv/StatefulPartitionedCall(^T1_CF_BatchNorm/StatefulPartitionedCall%^T1_CF_Conv2D/StatefulPartitionedCall&^T1_CF_Dropout/StatefulPartitionedCall(^T2_CF_BatchNorm/StatefulPartitionedCall%^T2_CF_Conv2D/StatefulPartitionedCall&^T2_CF_Dropout/StatefulPartitionedCall(^T3_CF_BatchNorm/StatefulPartitionedCall%^T3_CF_Conv2D/StatefulPartitionedCall&^T3_CF_Dropout/StatefulPartitionedCall,^batch_normalization/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*�
_input_shapes�
�:���������-C: :: : : : :: : : : :: : : : :: : : : :: : : : : : : : : : : : : : :: : : : :(: : : : :(: : : : :,: : : : : : : : : 2T
(B1_CF1_BatchNorm/StatefulPartitionedCall(B1_CF1_BatchNorm/StatefulPartitionedCall2N
%B1_CF1_Conv2D/StatefulPartitionedCall%B1_CF1_Conv2D/StatefulPartitionedCall2P
&B1_CF1_Dropout/StatefulPartitionedCall&B1_CF1_Dropout/StatefulPartitionedCall2T
(B1_CF2_BatchNorm/StatefulPartitionedCall(B1_CF2_BatchNorm/StatefulPartitionedCall2N
%B1_CF2_Conv2D/StatefulPartitionedCall%B1_CF2_Conv2D/StatefulPartitionedCall2P
&B1_CF2_Dropout/StatefulPartitionedCall&B1_CF2_Dropout/StatefulPartitionedCall2T
(B2_CF1_BatchNorm/StatefulPartitionedCall(B2_CF1_BatchNorm/StatefulPartitionedCall2N
%B2_CF1_Conv2D/StatefulPartitionedCall%B2_CF1_Conv2D/StatefulPartitionedCall2P
&B2_CF1_Dropout/StatefulPartitionedCall&B2_CF1_Dropout/StatefulPartitionedCall2T
(B2_CF2_BatchNorm/StatefulPartitionedCall(B2_CF2_BatchNorm/StatefulPartitionedCall2N
%B2_CF2_Conv2D/StatefulPartitionedCall%B2_CF2_Conv2D/StatefulPartitionedCall2P
&B2_CF2_Dropout/StatefulPartitionedCall&B2_CF2_Dropout/StatefulPartitionedCall2T
(B3_CF1_BatchNorm/StatefulPartitionedCall(B3_CF1_BatchNorm/StatefulPartitionedCall2N
%B3_CF1_Conv2D/StatefulPartitionedCall%B3_CF1_Conv2D/StatefulPartitionedCall2P
&B3_CF1_Dropout/StatefulPartitionedCall&B3_CF1_Dropout/StatefulPartitionedCall2T
(B3_CF2_BatchNorm/StatefulPartitionedCall(B3_CF2_BatchNorm/StatefulPartitionedCall2N
%B3_CF2_Conv2D/StatefulPartitionedCall%B3_CF2_Conv2D/StatefulPartitionedCall2P
&B3_CF2_Dropout/StatefulPartitionedCall&B3_CF2_Dropout/StatefulPartitionedCall2T
(B4_CF1_BatchNorm/StatefulPartitionedCall(B4_CF1_BatchNorm/StatefulPartitionedCall2N
%B4_CF1_Conv2D/StatefulPartitionedCall%B4_CF1_Conv2D/StatefulPartitionedCall2P
&B4_CF1_Dropout/StatefulPartitionedCall&B4_CF1_Dropout/StatefulPartitionedCall2L
$BatchNorm-D1/StatefulPartitionedCall$BatchNorm-D1/StatefulPartitionedCall2>
FC-D1/StatefulPartitionedCallFC-D1/StatefulPartitionedCall2@
Logits/StatefulPartitionedCallLogits/StatefulPartitionedCall2D
 Pre_Conv/StatefulPartitionedCall Pre_Conv/StatefulPartitionedCall2R
'T1_CF_BatchNorm/StatefulPartitionedCall'T1_CF_BatchNorm/StatefulPartitionedCall2L
$T1_CF_Conv2D/StatefulPartitionedCall$T1_CF_Conv2D/StatefulPartitionedCall2N
%T1_CF_Dropout/StatefulPartitionedCall%T1_CF_Dropout/StatefulPartitionedCall2R
'T2_CF_BatchNorm/StatefulPartitionedCall'T2_CF_BatchNorm/StatefulPartitionedCall2L
$T2_CF_Conv2D/StatefulPartitionedCall$T2_CF_Conv2D/StatefulPartitionedCall2N
%T2_CF_Dropout/StatefulPartitionedCall%T2_CF_Dropout/StatefulPartitionedCall2R
'T3_CF_BatchNorm/StatefulPartitionedCall'T3_CF_BatchNorm/StatefulPartitionedCall2L
$T3_CF_Conv2D/StatefulPartitionedCall$T3_CF_Conv2D/StatefulPartitionedCall2N
%T3_CF_Dropout/StatefulPartitionedCall%T3_CF_Dropout/StatefulPartitionedCall2Z
+batch_normalization/StatefulPartitionedCall+batch_normalization/StatefulPartitionedCall:S O
+
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
: :  

_output_shapes
: : %

_output_shapes
:: *

_output_shapes
:(: /

_output_shapes
:(: 4

_output_shapes
:,
�

g
H__inference_B1_CF1_Dropout_layer_call_and_return_conditional_losses_6398

inputs
identity�R
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?l
dropout/MulMulinputsdropout/Const:output:0*
T0*/
_output_shapes
:���������-CC
dropout/ShapeShapeinputs*
T0*
_output_shapes
:�
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*/
_output_shapes
:���������-C*
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������-Cw
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������-Cq
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*/
_output_shapes
:���������-Ca
IdentityIdentitydropout/Mul_1:z:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
�
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_7392

inputs	
scale%
readvariableop_resource: 6
(fusedbatchnormv3_readvariableop_resource: 8
*fusedbatchnormv3_readvariableop_1_resource: 
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+��������������������������� : : : : :*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+��������������������������� �
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+��������������������������� : : : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+��������������������������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
�
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_7015

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
��
�.
B__inference_DenseNet_layer_call_and_return_conditional_losses_6200

inputsA
'pre_conv_conv2d_readvariableop_resource:
b1_cf1_batchnorm_scale6
(b1_cf1_batchnorm_readvariableop_resource:G
9b1_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource:I
;b1_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource:F
,b1_cf1_conv2d_conv2d_readvariableop_resource:
b1_cf2_batchnorm_scale6
(b1_cf2_batchnorm_readvariableop_resource:G
9b1_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource:I
;b1_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource:F
,b1_cf2_conv2d_conv2d_readvariableop_resource:
t1_cf_batchnorm_scale5
't1_cf_batchnorm_readvariableop_resource:F
8t1_cf_batchnorm_fusedbatchnormv3_readvariableop_resource:H
:t1_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource:E
+t1_cf_conv2d_conv2d_readvariableop_resource:
b2_cf1_batchnorm_scale6
(b2_cf1_batchnorm_readvariableop_resource:G
9b2_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource:I
;b2_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource:F
,b2_cf1_conv2d_conv2d_readvariableop_resource:
b2_cf2_batchnorm_scale6
(b2_cf2_batchnorm_readvariableop_resource:G
9b2_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource:I
;b2_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource:F
,b2_cf2_conv2d_conv2d_readvariableop_resource:
t2_cf_batchnorm_scale5
't2_cf_batchnorm_readvariableop_resource: F
8t2_cf_batchnorm_fusedbatchnormv3_readvariableop_resource: H
:t2_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource: E
+t2_cf_conv2d_conv2d_readvariableop_resource:  
b3_cf1_batchnorm_scale6
(b3_cf1_batchnorm_readvariableop_resource: G
9b3_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource: I
;b3_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource: F
,b3_cf1_conv2d_conv2d_readvariableop_resource: 
b3_cf2_batchnorm_scale6
(b3_cf2_batchnorm_readvariableop_resource:G
9b3_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource:I
;b3_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource:F
,b3_cf2_conv2d_conv2d_readvariableop_resource:
t3_cf_batchnorm_scale5
't3_cf_batchnorm_readvariableop_resource:(F
8t3_cf_batchnorm_fusedbatchnormv3_readvariableop_resource:(H
:t3_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource:(E
+t3_cf_conv2d_conv2d_readvariableop_resource:((
b4_cf1_batchnorm_scale6
(b4_cf1_batchnorm_readvariableop_resource:(G
9b4_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource:(I
;b4_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource:(F
,b4_cf1_conv2d_conv2d_readvariableop_resource:(
batch_normalization_scale9
+batch_normalization_readvariableop_resource:,J
<batch_normalization_fusedbatchnormv3_readvariableop_resource:,L
>batch_normalization_fusedbatchnormv3_readvariableop_1_resource:,6
$fc_d1_matmul_readvariableop_resource:,<
.batchnorm_d1_batchnorm_readvariableop_resource:>
0batchnorm_d1_batchnorm_readvariableop_1_resource:>
0batchnorm_d1_batchnorm_readvariableop_2_resource:7
%logits_matmul_readvariableop_resource:4
&logits_biasadd_readvariableop_resource:
identity��0B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp�2B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�B1_CF1_BatchNorm/ReadVariableOp�#B1_CF1_Conv2D/Conv2D/ReadVariableOp�0B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp�2B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�B1_CF2_BatchNorm/ReadVariableOp�#B1_CF2_Conv2D/Conv2D/ReadVariableOp�0B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp�2B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�B2_CF1_BatchNorm/ReadVariableOp�#B2_CF1_Conv2D/Conv2D/ReadVariableOp�0B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp�2B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�B2_CF2_BatchNorm/ReadVariableOp�#B2_CF2_Conv2D/Conv2D/ReadVariableOp�0B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp�2B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�B3_CF1_BatchNorm/ReadVariableOp�#B3_CF1_Conv2D/Conv2D/ReadVariableOp�0B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp�2B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�B3_CF2_BatchNorm/ReadVariableOp�#B3_CF2_Conv2D/Conv2D/ReadVariableOp�0B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp�2B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�B4_CF1_BatchNorm/ReadVariableOp�#B4_CF1_Conv2D/Conv2D/ReadVariableOp�%BatchNorm-D1/batchnorm/ReadVariableOp�'BatchNorm-D1/batchnorm/ReadVariableOp_1�'BatchNorm-D1/batchnorm/ReadVariableOp_2�FC-D1/MatMul/ReadVariableOp�Logits/BiasAdd/ReadVariableOp�Logits/MatMul/ReadVariableOp�Pre_Conv/Conv2D/ReadVariableOp�/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp�1T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�T1_CF_BatchNorm/ReadVariableOp�"T1_CF_Conv2D/Conv2D/ReadVariableOp�/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp�1T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�T2_CF_BatchNorm/ReadVariableOp�"T2_CF_Conv2D/Conv2D/ReadVariableOp�/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp�1T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�T3_CF_BatchNorm/ReadVariableOp�"T3_CF_Conv2D/Conv2D/ReadVariableOp�3batch_normalization/FusedBatchNormV3/ReadVariableOp�5batch_normalization/FusedBatchNormV3/ReadVariableOp_1�"batch_normalization/ReadVariableOp_
tf.expand_dims/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B :�
tf.expand_dims/ExpandDims
ExpandDimsinputs&tf.expand_dims/ExpandDims/dim:output:0*
T0*/
_output_shapes
:���������-CU
rescaling/Cast/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<W
rescaling/Cast_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *  �?�
rescaling/mulMul"tf.expand_dims/ExpandDims:output:0rescaling/Cast/x:output:0*
T0*/
_output_shapes
:���������-C�
rescaling/addAddV2rescaling/mul:z:0rescaling/Cast_1/x:output:0*
T0*/
_output_shapes
:���������-C�
Pre_Conv/Conv2D/ReadVariableOpReadVariableOp'pre_conv_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
Pre_Conv/Conv2DConv2Drescaling/add:z:0&Pre_Conv/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
�
B1_CF1_BatchNorm/ReadVariableOpReadVariableOp(b1_cf1_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
0B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOp9b1_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
2B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp;b1_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
!B1_CF1_BatchNorm/FusedBatchNormV3FusedBatchNormV3Pre_Conv/Conv2D:output:0b1_cf1_batchnorm_scale'B1_CF1_BatchNorm/ReadVariableOp:value:08B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0:B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( y
B1_CF1_ReLu/ReluRelu%B1_CF1_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������-C�
#B1_CF1_Conv2D/Conv2D/ReadVariableOpReadVariableOp,b1_cf1_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
B1_CF1_Conv2D/Conv2DConv2DB1_CF1_ReLu/Relu:activations:0+B1_CF1_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
a
B1_CF1_Dropout/dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?�
B1_CF1_Dropout/dropout/MulMulB1_CF1_Conv2D/Conv2D:output:0%B1_CF1_Dropout/dropout/Const:output:0*
T0*/
_output_shapes
:���������-Ci
B1_CF1_Dropout/dropout/ShapeShapeB1_CF1_Conv2D/Conv2D:output:0*
T0*
_output_shapes
:�
3B1_CF1_Dropout/dropout/random_uniform/RandomUniformRandomUniform%B1_CF1_Dropout/dropout/Shape:output:0*
T0*/
_output_shapes
:���������-C*
dtype0j
%B1_CF1_Dropout/dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
#B1_CF1_Dropout/dropout/GreaterEqualGreaterEqual<B1_CF1_Dropout/dropout/random_uniform/RandomUniform:output:0.B1_CF1_Dropout/dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������-C�
B1_CF1_Dropout/dropout/CastCast'B1_CF1_Dropout/dropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������-C�
B1_CF1_Dropout/dropout/Mul_1MulB1_CF1_Dropout/dropout/Mul:z:0B1_CF1_Dropout/dropout/Cast:y:0*
T0*/
_output_shapes
:���������-C�
B1_CF2_BatchNorm/ReadVariableOpReadVariableOp(b1_cf2_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
0B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOp9b1_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
2B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp;b1_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
!B1_CF2_BatchNorm/FusedBatchNormV3FusedBatchNormV3 B1_CF1_Dropout/dropout/Mul_1:z:0b1_cf2_batchnorm_scale'B1_CF2_BatchNorm/ReadVariableOp:value:08B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0:B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( y
B1_CF2_ReLu/ReluRelu%B1_CF2_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������-C�
#B1_CF2_Conv2D/Conv2D/ReadVariableOpReadVariableOp,b1_cf2_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
B1_CF2_Conv2D/Conv2DConv2DB1_CF2_ReLu/Relu:activations:0+B1_CF2_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
a
B1_CF2_Dropout/dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?�
B1_CF2_Dropout/dropout/MulMulB1_CF2_Conv2D/Conv2D:output:0%B1_CF2_Dropout/dropout/Const:output:0*
T0*/
_output_shapes
:���������-Ci
B1_CF2_Dropout/dropout/ShapeShapeB1_CF2_Conv2D/Conv2D:output:0*
T0*
_output_shapes
:�
3B1_CF2_Dropout/dropout/random_uniform/RandomUniformRandomUniform%B1_CF2_Dropout/dropout/Shape:output:0*
T0*/
_output_shapes
:���������-C*
dtype0j
%B1_CF2_Dropout/dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
#B1_CF2_Dropout/dropout/GreaterEqualGreaterEqual<B1_CF2_Dropout/dropout/random_uniform/RandomUniform:output:0.B1_CF2_Dropout/dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������-C�
B1_CF2_Dropout/dropout/CastCast'B1_CF2_Dropout/dropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������-C�
B1_CF2_Dropout/dropout/Mul_1MulB1_CF2_Dropout/dropout/Mul:z:0B1_CF2_Dropout/dropout/Cast:y:0*
T0*/
_output_shapes
:���������-CW
B1_Concat/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
B1_Concat/concatConcatV2Pre_Conv/Conv2D:output:0 B1_CF1_Dropout/dropout/Mul_1:z:0 B1_CF2_Dropout/dropout/Mul_1:z:0B1_Concat/concat/axis:output:0*
N*
T0*/
_output_shapes
:���������-C�
T1_CF_BatchNorm/ReadVariableOpReadVariableOp't1_cf_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOp8t1_cf_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
1T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp:t1_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
 T1_CF_BatchNorm/FusedBatchNormV3FusedBatchNormV3B1_Concat/concat:output:0t1_cf_batchnorm_scale&T1_CF_BatchNorm/ReadVariableOp:value:07T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:09T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( w
T1_CF_ReLu/ReluRelu$T1_CF_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������-C�
"T1_CF_Conv2D/Conv2D/ReadVariableOpReadVariableOp+t1_cf_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
T1_CF_Conv2D/Conv2DConv2DT1_CF_ReLu/Relu:activations:0*T1_CF_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingVALID*
strides
`
T1_CF_Dropout/dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?�
T1_CF_Dropout/dropout/MulMulT1_CF_Conv2D/Conv2D:output:0$T1_CF_Dropout/dropout/Const:output:0*
T0*/
_output_shapes
:���������-Cg
T1_CF_Dropout/dropout/ShapeShapeT1_CF_Conv2D/Conv2D:output:0*
T0*
_output_shapes
:�
2T1_CF_Dropout/dropout/random_uniform/RandomUniformRandomUniform$T1_CF_Dropout/dropout/Shape:output:0*
T0*/
_output_shapes
:���������-C*
dtype0i
$T1_CF_Dropout/dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
"T1_CF_Dropout/dropout/GreaterEqualGreaterEqual;T1_CF_Dropout/dropout/random_uniform/RandomUniform:output:0-T1_CF_Dropout/dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������-C�
T1_CF_Dropout/dropout/CastCast&T1_CF_Dropout/dropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������-C�
T1_CF_Dropout/dropout/Mul_1MulT1_CF_Dropout/dropout/Mul:z:0T1_CF_Dropout/dropout/Cast:y:0*
T0*/
_output_shapes
:���������-C�
tf.compat.v1.pad/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
tf.compat.v1.pad/PadPadT1_CF_Dropout/dropout/Mul_1:z:0&tf.compat.v1.pad/Pad/paddings:output:0*
T0*/
_output_shapes
:���������-E�
T1_Pool/AvgPoolAvgPooltf.compat.v1.pad/Pad:output:0*
T0*/
_output_shapes
:���������*
ksize
*
paddingVALID*
strides
�
B2_CF1_BatchNorm/ReadVariableOpReadVariableOp(b2_cf1_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
0B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOp9b2_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
2B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp;b2_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
!B2_CF1_BatchNorm/FusedBatchNormV3FusedBatchNormV3T1_Pool/AvgPool:output:0b2_cf1_batchnorm_scale'B2_CF1_BatchNorm/ReadVariableOp:value:08B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0:B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( y
B2_CF1_ReLu/ReluRelu%B2_CF1_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:����������
#B2_CF1_Conv2D/Conv2D/ReadVariableOpReadVariableOp,b2_cf1_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
B2_CF1_Conv2D/Conv2DConv2DB2_CF1_ReLu/Relu:activations:0+B2_CF1_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
a
B2_CF1_Dropout/dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?�
B2_CF1_Dropout/dropout/MulMulB2_CF1_Conv2D/Conv2D:output:0%B2_CF1_Dropout/dropout/Const:output:0*
T0*/
_output_shapes
:���������i
B2_CF1_Dropout/dropout/ShapeShapeB2_CF1_Conv2D/Conv2D:output:0*
T0*
_output_shapes
:�
3B2_CF1_Dropout/dropout/random_uniform/RandomUniformRandomUniform%B2_CF1_Dropout/dropout/Shape:output:0*
T0*/
_output_shapes
:���������*
dtype0j
%B2_CF1_Dropout/dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
#B2_CF1_Dropout/dropout/GreaterEqualGreaterEqual<B2_CF1_Dropout/dropout/random_uniform/RandomUniform:output:0.B2_CF1_Dropout/dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:����������
B2_CF1_Dropout/dropout/CastCast'B2_CF1_Dropout/dropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:����������
B2_CF1_Dropout/dropout/Mul_1MulB2_CF1_Dropout/dropout/Mul:z:0B2_CF1_Dropout/dropout/Cast:y:0*
T0*/
_output_shapes
:����������
B2_CF2_BatchNorm/ReadVariableOpReadVariableOp(b2_cf2_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
0B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOp9b2_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
2B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp;b2_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
!B2_CF2_BatchNorm/FusedBatchNormV3FusedBatchNormV3 B2_CF1_Dropout/dropout/Mul_1:z:0b2_cf2_batchnorm_scale'B2_CF2_BatchNorm/ReadVariableOp:value:08B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0:B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( y
B2_CF2_ReLu/ReluRelu%B2_CF2_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:����������
#B2_CF2_Conv2D/Conv2D/ReadVariableOpReadVariableOp,b2_cf2_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
B2_CF2_Conv2D/Conv2DConv2DB2_CF2_ReLu/Relu:activations:0+B2_CF2_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
a
B2_CF2_Dropout/dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?�
B2_CF2_Dropout/dropout/MulMulB2_CF2_Conv2D/Conv2D:output:0%B2_CF2_Dropout/dropout/Const:output:0*
T0*/
_output_shapes
:���������i
B2_CF2_Dropout/dropout/ShapeShapeB2_CF2_Conv2D/Conv2D:output:0*
T0*
_output_shapes
:�
3B2_CF2_Dropout/dropout/random_uniform/RandomUniformRandomUniform%B2_CF2_Dropout/dropout/Shape:output:0*
T0*/
_output_shapes
:���������*
dtype0j
%B2_CF2_Dropout/dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
#B2_CF2_Dropout/dropout/GreaterEqualGreaterEqual<B2_CF2_Dropout/dropout/random_uniform/RandomUniform:output:0.B2_CF2_Dropout/dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:����������
B2_CF2_Dropout/dropout/CastCast'B2_CF2_Dropout/dropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:����������
B2_CF2_Dropout/dropout/Mul_1MulB2_CF2_Dropout/dropout/Mul:z:0B2_CF2_Dropout/dropout/Cast:y:0*
T0*/
_output_shapes
:���������W
B2_Concat/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
B2_Concat/concatConcatV2T1_Pool/AvgPool:output:0 B2_CF1_Dropout/dropout/Mul_1:z:0 B2_CF2_Dropout/dropout/Mul_1:z:0B2_Concat/concat/axis:output:0*
N*
T0*/
_output_shapes
:��������� �
T2_CF_BatchNorm/ReadVariableOpReadVariableOp't2_cf_batchnorm_readvariableop_resource*
_output_shapes
: *
dtype0�
/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOp8t2_cf_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
1T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp:t2_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
 T2_CF_BatchNorm/FusedBatchNormV3FusedBatchNormV3B2_Concat/concat:output:0t2_cf_batchnorm_scale&T2_CF_BatchNorm/ReadVariableOp:value:07T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:09T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:��������� : : : : :*
epsilon%o�:*
is_training( w
T2_CF_ReLu/ReluRelu$T2_CF_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:��������� �
"T2_CF_Conv2D/Conv2D/ReadVariableOpReadVariableOp+t2_cf_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:  *
dtype0�
T2_CF_Conv2D/Conv2DConv2DT2_CF_ReLu/Relu:activations:0*T2_CF_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:��������� *
paddingVALID*
strides
`
T2_CF_Dropout/dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?�
T2_CF_Dropout/dropout/MulMulT2_CF_Conv2D/Conv2D:output:0$T2_CF_Dropout/dropout/Const:output:0*
T0*/
_output_shapes
:��������� g
T2_CF_Dropout/dropout/ShapeShapeT2_CF_Conv2D/Conv2D:output:0*
T0*
_output_shapes
:�
2T2_CF_Dropout/dropout/random_uniform/RandomUniformRandomUniform$T2_CF_Dropout/dropout/Shape:output:0*
T0*/
_output_shapes
:��������� *
dtype0i
$T2_CF_Dropout/dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
"T2_CF_Dropout/dropout/GreaterEqualGreaterEqual;T2_CF_Dropout/dropout/random_uniform/RandomUniform:output:0-T2_CF_Dropout/dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:��������� �
T2_CF_Dropout/dropout/CastCast&T2_CF_Dropout/dropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:��������� �
T2_CF_Dropout/dropout/Mul_1MulT2_CF_Dropout/dropout/Mul:z:0T2_CF_Dropout/dropout/Cast:y:0*
T0*/
_output_shapes
:��������� �
tf.compat.v1.pad_1/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
tf.compat.v1.pad_1/PadPadT2_CF_Dropout/dropout/Mul_1:z:0(tf.compat.v1.pad_1/Pad/paddings:output:0*
T0*/
_output_shapes
:��������� �
T2_Pool/AvgPoolAvgPooltf.compat.v1.pad_1/Pad:output:0*
T0*/
_output_shapes
:��������� *
ksize
*
paddingVALID*
strides
�
B3_CF1_BatchNorm/ReadVariableOpReadVariableOp(b3_cf1_batchnorm_readvariableop_resource*
_output_shapes
: *
dtype0�
0B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOp9b3_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
2B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp;b3_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
!B3_CF1_BatchNorm/FusedBatchNormV3FusedBatchNormV3T2_Pool/AvgPool:output:0b3_cf1_batchnorm_scale'B3_CF1_BatchNorm/ReadVariableOp:value:08B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0:B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:��������� : : : : :*
epsilon%o�:*
is_training( y
B3_CF1_ReLu/ReluRelu%B3_CF1_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:��������� �
#B3_CF1_Conv2D/Conv2D/ReadVariableOpReadVariableOp,b3_cf1_conv2d_conv2d_readvariableop_resource*&
_output_shapes
: *
dtype0�
B3_CF1_Conv2D/Conv2DConv2DB3_CF1_ReLu/Relu:activations:0+B3_CF1_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
a
B3_CF1_Dropout/dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?�
B3_CF1_Dropout/dropout/MulMulB3_CF1_Conv2D/Conv2D:output:0%B3_CF1_Dropout/dropout/Const:output:0*
T0*/
_output_shapes
:���������i
B3_CF1_Dropout/dropout/ShapeShapeB3_CF1_Conv2D/Conv2D:output:0*
T0*
_output_shapes
:�
3B3_CF1_Dropout/dropout/random_uniform/RandomUniformRandomUniform%B3_CF1_Dropout/dropout/Shape:output:0*
T0*/
_output_shapes
:���������*
dtype0j
%B3_CF1_Dropout/dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
#B3_CF1_Dropout/dropout/GreaterEqualGreaterEqual<B3_CF1_Dropout/dropout/random_uniform/RandomUniform:output:0.B3_CF1_Dropout/dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:����������
B3_CF1_Dropout/dropout/CastCast'B3_CF1_Dropout/dropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:����������
B3_CF1_Dropout/dropout/Mul_1MulB3_CF1_Dropout/dropout/Mul:z:0B3_CF1_Dropout/dropout/Cast:y:0*
T0*/
_output_shapes
:����������
B3_CF2_BatchNorm/ReadVariableOpReadVariableOp(b3_cf2_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
0B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOp9b3_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
2B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp;b3_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
!B3_CF2_BatchNorm/FusedBatchNormV3FusedBatchNormV3 B3_CF1_Dropout/dropout/Mul_1:z:0b3_cf2_batchnorm_scale'B3_CF2_BatchNorm/ReadVariableOp:value:08B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0:B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( y
B3_CF2_ReLu/ReluRelu%B3_CF2_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:����������
#B3_CF2_Conv2D/Conv2D/ReadVariableOpReadVariableOp,b3_cf2_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
B3_CF2_Conv2D/Conv2DConv2DB3_CF2_ReLu/Relu:activations:0+B3_CF2_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
a
B3_CF2_Dropout/dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?�
B3_CF2_Dropout/dropout/MulMulB3_CF2_Conv2D/Conv2D:output:0%B3_CF2_Dropout/dropout/Const:output:0*
T0*/
_output_shapes
:���������i
B3_CF2_Dropout/dropout/ShapeShapeB3_CF2_Conv2D/Conv2D:output:0*
T0*
_output_shapes
:�
3B3_CF2_Dropout/dropout/random_uniform/RandomUniformRandomUniform%B3_CF2_Dropout/dropout/Shape:output:0*
T0*/
_output_shapes
:���������*
dtype0j
%B3_CF2_Dropout/dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
#B3_CF2_Dropout/dropout/GreaterEqualGreaterEqual<B3_CF2_Dropout/dropout/random_uniform/RandomUniform:output:0.B3_CF2_Dropout/dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:����������
B3_CF2_Dropout/dropout/CastCast'B3_CF2_Dropout/dropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:����������
B3_CF2_Dropout/dropout/Mul_1MulB3_CF2_Dropout/dropout/Mul:z:0B3_CF2_Dropout/dropout/Cast:y:0*
T0*/
_output_shapes
:���������W
B3_Concat/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
B3_Concat/concatConcatV2T2_Pool/AvgPool:output:0 B3_CF1_Dropout/dropout/Mul_1:z:0 B3_CF2_Dropout/dropout/Mul_1:z:0B3_Concat/concat/axis:output:0*
N*
T0*/
_output_shapes
:���������(�
T3_CF_BatchNorm/ReadVariableOpReadVariableOp't3_cf_batchnorm_readvariableop_resource*
_output_shapes
:(*
dtype0�
/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOp8t3_cf_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
1T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp:t3_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
 T3_CF_BatchNorm/FusedBatchNormV3FusedBatchNormV3B3_Concat/concat:output:0t3_cf_batchnorm_scale&T3_CF_BatchNorm/ReadVariableOp:value:07T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:09T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������(:(:(:(:(:*
epsilon%o�:*
is_training( w
T3_CF_ReLu/ReluRelu$T3_CF_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������(�
"T3_CF_Conv2D/Conv2D/ReadVariableOpReadVariableOp+t3_cf_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:((*
dtype0�
T3_CF_Conv2D/Conv2DConv2DT3_CF_ReLu/Relu:activations:0*T3_CF_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������(*
paddingVALID*
strides
`
T3_CF_Dropout/dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?�
T3_CF_Dropout/dropout/MulMulT3_CF_Conv2D/Conv2D:output:0$T3_CF_Dropout/dropout/Const:output:0*
T0*/
_output_shapes
:���������(g
T3_CF_Dropout/dropout/ShapeShapeT3_CF_Conv2D/Conv2D:output:0*
T0*
_output_shapes
:�
2T3_CF_Dropout/dropout/random_uniform/RandomUniformRandomUniform$T3_CF_Dropout/dropout/Shape:output:0*
T0*/
_output_shapes
:���������(*
dtype0i
$T3_CF_Dropout/dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
"T3_CF_Dropout/dropout/GreaterEqualGreaterEqual;T3_CF_Dropout/dropout/random_uniform/RandomUniform:output:0-T3_CF_Dropout/dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������(�
T3_CF_Dropout/dropout/CastCast&T3_CF_Dropout/dropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������(�
T3_CF_Dropout/dropout/Mul_1MulT3_CF_Dropout/dropout/Mul:z:0T3_CF_Dropout/dropout/Cast:y:0*
T0*/
_output_shapes
:���������(�
tf.compat.v1.pad_2/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
tf.compat.v1.pad_2/PadPadT3_CF_Dropout/dropout/Mul_1:z:0(tf.compat.v1.pad_2/Pad/paddings:output:0*
T0*/
_output_shapes
:���������	(�
T3_Pool/AvgPoolAvgPooltf.compat.v1.pad_2/Pad:output:0*
T0*/
_output_shapes
:���������(*
ksize
*
paddingVALID*
strides
�
B4_CF1_BatchNorm/ReadVariableOpReadVariableOp(b4_cf1_batchnorm_readvariableop_resource*
_output_shapes
:(*
dtype0�
0B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOp9b4_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
2B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp;b4_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
!B4_CF1_BatchNorm/FusedBatchNormV3FusedBatchNormV3T3_Pool/AvgPool:output:0b4_cf1_batchnorm_scale'B4_CF1_BatchNorm/ReadVariableOp:value:08B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0:B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������(:(:(:(:(:*
epsilon%o�:*
is_training( y
B4_CF1_ReLu/ReluRelu%B4_CF1_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������(�
#B4_CF1_Conv2D/Conv2D/ReadVariableOpReadVariableOp,b4_cf1_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:(*
dtype0�
B4_CF1_Conv2D/Conv2DConv2DB4_CF1_ReLu/Relu:activations:0+B4_CF1_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
a
B4_CF1_Dropout/dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?�
B4_CF1_Dropout/dropout/MulMulB4_CF1_Conv2D/Conv2D:output:0%B4_CF1_Dropout/dropout/Const:output:0*
T0*/
_output_shapes
:���������i
B4_CF1_Dropout/dropout/ShapeShapeB4_CF1_Conv2D/Conv2D:output:0*
T0*
_output_shapes
:�
3B4_CF1_Dropout/dropout/random_uniform/RandomUniformRandomUniform%B4_CF1_Dropout/dropout/Shape:output:0*
T0*/
_output_shapes
:���������*
dtype0j
%B4_CF1_Dropout/dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
#B4_CF1_Dropout/dropout/GreaterEqualGreaterEqual<B4_CF1_Dropout/dropout/random_uniform/RandomUniform:output:0.B4_CF1_Dropout/dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:����������
B4_CF1_Dropout/dropout/CastCast'B4_CF1_Dropout/dropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:����������
B4_CF1_Dropout/dropout/Mul_1MulB4_CF1_Dropout/dropout/Mul:z:0B4_CF1_Dropout/dropout/Cast:y:0*
T0*/
_output_shapes
:���������W
B4_Concat/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
B4_Concat/concatConcatV2T3_Pool/AvgPool:output:0 B4_CF1_Dropout/dropout/Mul_1:z:0B4_Concat/concat/axis:output:0*
N*
T0*/
_output_shapes
:���������,�
"batch_normalization/ReadVariableOpReadVariableOp+batch_normalization_readvariableop_resource*
_output_shapes
:,*
dtype0�
3batch_normalization/FusedBatchNormV3/ReadVariableOpReadVariableOp<batch_normalization_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:,*
dtype0�
5batch_normalization/FusedBatchNormV3/ReadVariableOp_1ReadVariableOp>batch_normalization_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:,*
dtype0�
$batch_normalization/FusedBatchNormV3FusedBatchNormV3B4_Concat/concat:output:0batch_normalization_scale*batch_normalization/ReadVariableOp:value:0;batch_normalization/FusedBatchNormV3/ReadVariableOp:value:0=batch_normalization/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������,:,:,:,:,:*
epsilon%��'7*
is_training( u
	ReLu/ReluRelu(batch_normalization/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������,�
/global_average_pooling2d/Mean/reduction_indicesConst*
_output_shapes
:*
dtype0*
valueB"      �
global_average_pooling2d/MeanMeanReLu/Relu:activations:08global_average_pooling2d/Mean/reduction_indices:output:0*
T0*'
_output_shapes
:���������,�
FC-D1/MatMul/ReadVariableOpReadVariableOp$fc_d1_matmul_readvariableop_resource*
_output_shapes

:,*
dtype0�
FC-D1/MatMulMatMul&global_average_pooling2d/Mean:output:0#FC-D1/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:����������
%BatchNorm-D1/batchnorm/ReadVariableOpReadVariableOp.batchnorm_d1_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0a
BatchNorm-D1/batchnorm/add/yConst*
_output_shapes
: *
dtype0*
valueB
 *w�+2�
BatchNorm-D1/batchnorm/addAddV2-BatchNorm-D1/batchnorm/ReadVariableOp:value:0%BatchNorm-D1/batchnorm/add/y:output:0*
T0*
_output_shapes
:j
BatchNorm-D1/batchnorm/RsqrtRsqrtBatchNorm-D1/batchnorm/add:z:0*
T0*
_output_shapes
:�
BatchNorm-D1/batchnorm/mulMulFC-D1/MatMul:product:0 BatchNorm-D1/batchnorm/Rsqrt:y:0*
T0*'
_output_shapes
:����������
'BatchNorm-D1/batchnorm/ReadVariableOp_1ReadVariableOp0batchnorm_d1_batchnorm_readvariableop_1_resource*
_output_shapes
:*
dtype0�
BatchNorm-D1/batchnorm/mul_1Mul/BatchNorm-D1/batchnorm/ReadVariableOp_1:value:0 BatchNorm-D1/batchnorm/Rsqrt:y:0*
T0*
_output_shapes
:�
'BatchNorm-D1/batchnorm/ReadVariableOp_2ReadVariableOp0batchnorm_d1_batchnorm_readvariableop_2_resource*
_output_shapes
:*
dtype0�
BatchNorm-D1/batchnorm/subSub/BatchNorm-D1/batchnorm/ReadVariableOp_2:value:0 BatchNorm-D1/batchnorm/mul_1:z:0*
T0*
_output_shapes
:�
BatchNorm-D1/batchnorm/add_1AddV2BatchNorm-D1/batchnorm/mul:z:0BatchNorm-D1/batchnorm/sub:z:0*
T0*'
_output_shapes
:����������
Logits/MatMul/ReadVariableOpReadVariableOp%logits_matmul_readvariableop_resource*
_output_shapes

:*
dtype0�
Logits/MatMulMatMul BatchNorm-D1/batchnorm/add_1:z:0$Logits/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:����������
Logits/BiasAdd/ReadVariableOpReadVariableOp&logits_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0�
Logits/BiasAddBiasAddLogits/MatMul:product:0%Logits/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������d
Logits/SigmoidSigmoidLogits/BiasAdd:output:0*
T0*'
_output_shapes
:���������a
IdentityIdentityLogits/Sigmoid:y:0^NoOp*
T0*'
_output_shapes
:����������
NoOpNoOp1^B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp3^B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1 ^B1_CF1_BatchNorm/ReadVariableOp$^B1_CF1_Conv2D/Conv2D/ReadVariableOp1^B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp3^B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1 ^B1_CF2_BatchNorm/ReadVariableOp$^B1_CF2_Conv2D/Conv2D/ReadVariableOp1^B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp3^B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1 ^B2_CF1_BatchNorm/ReadVariableOp$^B2_CF1_Conv2D/Conv2D/ReadVariableOp1^B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp3^B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1 ^B2_CF2_BatchNorm/ReadVariableOp$^B2_CF2_Conv2D/Conv2D/ReadVariableOp1^B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp3^B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1 ^B3_CF1_BatchNorm/ReadVariableOp$^B3_CF1_Conv2D/Conv2D/ReadVariableOp1^B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp3^B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1 ^B3_CF2_BatchNorm/ReadVariableOp$^B3_CF2_Conv2D/Conv2D/ReadVariableOp1^B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp3^B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1 ^B4_CF1_BatchNorm/ReadVariableOp$^B4_CF1_Conv2D/Conv2D/ReadVariableOp&^BatchNorm-D1/batchnorm/ReadVariableOp(^BatchNorm-D1/batchnorm/ReadVariableOp_1(^BatchNorm-D1/batchnorm/ReadVariableOp_2^FC-D1/MatMul/ReadVariableOp^Logits/BiasAdd/ReadVariableOp^Logits/MatMul/ReadVariableOp^Pre_Conv/Conv2D/ReadVariableOp0^T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2^T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1^T1_CF_BatchNorm/ReadVariableOp#^T1_CF_Conv2D/Conv2D/ReadVariableOp0^T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2^T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1^T2_CF_BatchNorm/ReadVariableOp#^T2_CF_Conv2D/Conv2D/ReadVariableOp0^T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2^T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1^T3_CF_BatchNorm/ReadVariableOp#^T3_CF_Conv2D/Conv2D/ReadVariableOp4^batch_normalization/FusedBatchNormV3/ReadVariableOp6^batch_normalization/FusedBatchNormV3/ReadVariableOp_1#^batch_normalization/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*�
_input_shapes�
�:���������-C: :: : : : :: : : : :: : : : :: : : : :: : : : : : : : : : : : : : :: : : : :(: : : : :(: : : : :,: : : : : : : : : 2d
0B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp0B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp2h
2B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B
B1_CF1_BatchNorm/ReadVariableOpB1_CF1_BatchNorm/ReadVariableOp2J
#B1_CF1_Conv2D/Conv2D/ReadVariableOp#B1_CF1_Conv2D/Conv2D/ReadVariableOp2d
0B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp0B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp2h
2B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B
B1_CF2_BatchNorm/ReadVariableOpB1_CF2_BatchNorm/ReadVariableOp2J
#B1_CF2_Conv2D/Conv2D/ReadVariableOp#B1_CF2_Conv2D/Conv2D/ReadVariableOp2d
0B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp0B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp2h
2B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B
B2_CF1_BatchNorm/ReadVariableOpB2_CF1_BatchNorm/ReadVariableOp2J
#B2_CF1_Conv2D/Conv2D/ReadVariableOp#B2_CF1_Conv2D/Conv2D/ReadVariableOp2d
0B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp0B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp2h
2B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B
B2_CF2_BatchNorm/ReadVariableOpB2_CF2_BatchNorm/ReadVariableOp2J
#B2_CF2_Conv2D/Conv2D/ReadVariableOp#B2_CF2_Conv2D/Conv2D/ReadVariableOp2d
0B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp0B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp2h
2B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B
B3_CF1_BatchNorm/ReadVariableOpB3_CF1_BatchNorm/ReadVariableOp2J
#B3_CF1_Conv2D/Conv2D/ReadVariableOp#B3_CF1_Conv2D/Conv2D/ReadVariableOp2d
0B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp0B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp2h
2B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B
B3_CF2_BatchNorm/ReadVariableOpB3_CF2_BatchNorm/ReadVariableOp2J
#B3_CF2_Conv2D/Conv2D/ReadVariableOp#B3_CF2_Conv2D/Conv2D/ReadVariableOp2d
0B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp0B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp2h
2B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12B
B4_CF1_BatchNorm/ReadVariableOpB4_CF1_BatchNorm/ReadVariableOp2J
#B4_CF1_Conv2D/Conv2D/ReadVariableOp#B4_CF1_Conv2D/Conv2D/ReadVariableOp2N
%BatchNorm-D1/batchnorm/ReadVariableOp%BatchNorm-D1/batchnorm/ReadVariableOp2R
'BatchNorm-D1/batchnorm/ReadVariableOp_1'BatchNorm-D1/batchnorm/ReadVariableOp_12R
'BatchNorm-D1/batchnorm/ReadVariableOp_2'BatchNorm-D1/batchnorm/ReadVariableOp_22:
FC-D1/MatMul/ReadVariableOpFC-D1/MatMul/ReadVariableOp2>
Logits/BiasAdd/ReadVariableOpLogits/BiasAdd/ReadVariableOp2<
Logits/MatMul/ReadVariableOpLogits/MatMul/ReadVariableOp2@
Pre_Conv/Conv2D/ReadVariableOpPre_Conv/Conv2D/ReadVariableOp2b
/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2f
1T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_11T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_12@
T1_CF_BatchNorm/ReadVariableOpT1_CF_BatchNorm/ReadVariableOp2H
"T1_CF_Conv2D/Conv2D/ReadVariableOp"T1_CF_Conv2D/Conv2D/ReadVariableOp2b
/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2f
1T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_11T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_12@
T2_CF_BatchNorm/ReadVariableOpT2_CF_BatchNorm/ReadVariableOp2H
"T2_CF_Conv2D/Conv2D/ReadVariableOp"T2_CF_Conv2D/Conv2D/ReadVariableOp2b
/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2f
1T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_11T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_12@
T3_CF_BatchNorm/ReadVariableOpT3_CF_BatchNorm/ReadVariableOp2H
"T3_CF_Conv2D/Conv2D/ReadVariableOp"T3_CF_Conv2D/Conv2D/ReadVariableOp2j
3batch_normalization/FusedBatchNormV3/ReadVariableOp3batch_normalization/FusedBatchNormV3/ReadVariableOp2n
5batch_normalization/FusedBatchNormV3/ReadVariableOp_15batch_normalization/FusedBatchNormV3/ReadVariableOp_12H
"batch_normalization/ReadVariableOp"batch_normalization/ReadVariableOp:S O
+
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
: :  

_output_shapes
: : %

_output_shapes
:: *

_output_shapes
:(: /

_output_shapes
:(: 4

_output_shapes
:,
�
]
A__inference_T1_Pool_layer_call_and_return_conditional_losses_2893

inputs
identity�
AvgPoolAvgPoolinputs*
T0*/
_output_shapes
:���������*
ksize
*
paddingVALID*
strides
`
IdentityIdentityAvgPool:output:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-E:W S
/
_output_shapes
:���������-E
 
_user_specified_nameinputs
�
�
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_7766

inputs	
scale%
readvariableop_resource:(6
(fusedbatchnormv3_readvariableop_resource:(8
*fusedbatchnormv3_readvariableop_1_resource:(
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������(:(:(:(:(:*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������(�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������(:(: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�
�
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_2248

inputs	
scale%
readvariableop_resource: 6
(fusedbatchnormv3_readvariableop_resource: 8
*fusedbatchnormv3_readvariableop_1_resource: 
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+��������������������������� : : : : :*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+��������������������������� �
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+��������������������������� : : : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+��������������������������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
�
G__inference_B2_CF1_Conv2D_layer_call_and_return_conditional_losses_2935

inputs8
conv2d_readvariableop_resource:
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:���������^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������: 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
x
$__inference_FC-D1_layer_call_fn_8214

inputs
unknown:,
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *H
fCRA
?__inference_FC-D1_layer_call_and_return_conditional_losses_3344o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*(
_input_shapes
:���������,: 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:���������,
 
_user_specified_nameinputs
�
�
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_2446

inputs	
scale%
readvariableop_resource:(6
(fusedbatchnormv3_readvariableop_resource:(8
*fusedbatchnormv3_readvariableop_1_resource:(
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������(:(:(:(:(:*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������(�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������(:(: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�
�
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_2154

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
B
&__inference_T2_Pool_layer_call_fn_7313

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *J
fERC
A__inference_T2_Pool_layer_call_and_return_conditional_losses_3064h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:��������� "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:��������� :W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
�	
�
.__inference_T3_CF_BatchNorm_layer_call_fn_7706

inputs
unknown
	unknown_0:(
	unknown_1:(
	unknown_2:(
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+���������������������������(*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_2476�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������(`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������(:(: : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+���������������������������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�

g
H__inference_B3_CF1_Dropout_layer_call_and_return_conditional_losses_3850

inputs
identity�R
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?l
dropout/MulMulinputsdropout/Const:output:0*
T0*/
_output_shapes
:���������C
dropout/ShapeShapeinputs*
T0*
_output_shapes
:�
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*/
_output_shapes
:���������*
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������w
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������q
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*/
_output_shapes
:���������a
IdentityIdentitydropout/Mul_1:z:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
e
G__inference_T2_CF_Dropout_layer_call_and_return_conditional_losses_7291

inputs

identity_1V
IdentityIdentityinputs*
T0*/
_output_shapes
:��������� c

Identity_1IdentityIdentity:output:0*
T0*/
_output_shapes
:��������� "!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:��������� :W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
�

g
H__inference_B1_CF2_Dropout_layer_call_and_return_conditional_losses_6569

inputs
identity�R
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?l
dropout/MulMulinputsdropout/Const:output:0*
T0*/
_output_shapes
:���������-CC
dropout/ShapeShapeinputs*
T0*
_output_shapes
:�
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*/
_output_shapes
:���������-C*
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������-Cw
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������-Cq
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*/
_output_shapes
:���������-Ca
IdentityIdentitydropout/Mul_1:z:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�

g
H__inference_B4_CF1_Dropout_layer_call_and_return_conditional_losses_8042

inputs
identity�R
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?l
dropout/MulMulinputsdropout/Const:output:0*
T0*/
_output_shapes
:���������C
dropout/ShapeShapeinputs*
T0*
_output_shapes
:�
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*/
_output_shapes
:���������*
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������w
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������q
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*/
_output_shapes
:���������a
IdentityIdentitydropout/Mul_1:z:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
a
E__inference_B2_CF1_ReLu_layer_call_and_return_conditional_losses_2926

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:���������b
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
G__inference_B1_CF1_Conv2D_layer_call_and_return_conditional_losses_6371

inputs8
conv2d_readvariableop_resource:
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:���������-C^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������-C: 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
�
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_7800

inputs	
scale%
readvariableop_resource:(6
(fusedbatchnormv3_readvariableop_resource:(8
*fusedbatchnormv3_readvariableop_1_resource:(
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������(:(:(:(:(:*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������(�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������(:(: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�
�
'__inference_DenseNet_layer_call_fn_5000
input_1!
unknown:
	unknown_0
	unknown_1:
	unknown_2:
	unknown_3:#
	unknown_4:
	unknown_5
	unknown_6:
	unknown_7:
	unknown_8:#
	unknown_9:

unknown_10

unknown_11:

unknown_12:

unknown_13:$

unknown_14:

unknown_15

unknown_16:

unknown_17:

unknown_18:$

unknown_19:

unknown_20

unknown_21:

unknown_22:

unknown_23:$

unknown_24:

unknown_25

unknown_26: 

unknown_27: 

unknown_28: $

unknown_29:  

unknown_30

unknown_31: 

unknown_32: 

unknown_33: $

unknown_34: 

unknown_35

unknown_36:

unknown_37:

unknown_38:$

unknown_39:

unknown_40

unknown_41:(

unknown_42:(

unknown_43:($

unknown_44:((

unknown_45

unknown_46:(

unknown_47:(

unknown_48:($

unknown_49:(

unknown_50

unknown_51:,

unknown_52:,

unknown_53:,

unknown_54:,

unknown_55:

unknown_56:

unknown_57:

unknown_58:

unknown_59:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinput_1unknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4	unknown_5	unknown_6	unknown_7	unknown_8	unknown_9
unknown_10
unknown_11
unknown_12
unknown_13
unknown_14
unknown_15
unknown_16
unknown_17
unknown_18
unknown_19
unknown_20
unknown_21
unknown_22
unknown_23
unknown_24
unknown_25
unknown_26
unknown_27
unknown_28
unknown_29
unknown_30
unknown_31
unknown_32
unknown_33
unknown_34
unknown_35
unknown_36
unknown_37
unknown_38
unknown_39
unknown_40
unknown_41
unknown_42
unknown_43
unknown_44
unknown_45
unknown_46
unknown_47
unknown_48
unknown_49
unknown_50
unknown_51
unknown_52
unknown_53
unknown_54
unknown_55
unknown_56
unknown_57
unknown_58
unknown_59*I
TinB
@2>*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*T
_read_only_resource_inputs6
42	
!"#$&'()+,-.012356789:;<=*-
config_proto

CPU

GPU 2J 8� *K
fFRD
B__inference_DenseNet_layer_call_and_return_conditional_losses_4748o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*�
_input_shapes�
�:���������-C: :: : : : :: : : : :: : : : :: : : : :: : : : : : : : : : : : : : :: : : : :(: : : : :(: : : : :,: : : : : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:T P
+
_output_shapes
:���������-C
!
_user_specified_name	input_1: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
: :  

_output_shapes
: : %

_output_shapes
:: *

_output_shapes
:(: /

_output_shapes
:(: 4

_output_shapes
:,
�
S
7__inference_global_average_pooling2d_layer_call_fn_8195

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������,* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *[
fVRT
R__inference_global_average_pooling2d_layer_call_and_return_conditional_losses_3335`
IdentityIdentityPartitionedCall:output:0*
T0*'
_output_shapes
:���������,"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������,:W S
/
_output_shapes
:���������,
 
_user_specified_nameinputs
�
I
-__inference_B3_CF2_Dropout_layer_call_fn_7643

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B3_CF2_Dropout_layer_call_and_return_conditional_losses_3166h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
G__inference_B2_CF2_Conv2D_layer_call_and_return_conditional_losses_2986

inputs8
conv2d_readvariableop_resource:
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:���������^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������: 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
`
D__inference_T3_CF_ReLu_layer_call_and_return_conditional_losses_3209

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:���������(b
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:���������("
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������(:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs
�
�
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_3082

inputs	
scale%
readvariableop_resource: 6
(fusedbatchnormv3_readvariableop_resource: 8
*fusedbatchnormv3_readvariableop_1_resource: 
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:��������� : : : : :*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:��������� �
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':��������� : : : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
`
D__inference_T1_CF_ReLu_layer_call_and_return_conditional_losses_6714

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:���������-Cb
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
�
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_2520

inputs	
scale%
readvariableop_resource:(6
(fusedbatchnormv3_readvariableop_resource:(8
*fusedbatchnormv3_readvariableop_1_resource:(
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������(:(:(:(:(:*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������(�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������(:(: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�
�
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_7201

inputs	
scale%
readvariableop_resource: 6
(fusedbatchnormv3_readvariableop_resource: 8
*fusedbatchnormv3_readvariableop_1_resource: 
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+��������������������������� : : : : :*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+��������������������������� �
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+��������������������������� : : : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+��������������������������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�

g
H__inference_B2_CF2_Dropout_layer_call_and_return_conditional_losses_4023

inputs
identity�R
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?l
dropout/MulMulinputsdropout/Const:output:0*
T0*/
_output_shapes
:���������C
dropout/ShapeShapeinputs*
T0*
_output_shapes
:�
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*/
_output_shapes
:���������*
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������w
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������q
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*/
_output_shapes
:���������a
IdentityIdentitydropout/Mul_1:z:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
G__inference_B1_CF1_Conv2D_layer_call_and_return_conditional_losses_2764

inputs8
conv2d_readvariableop_resource:
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:���������-C^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������-C: 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
�
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_2414

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
G__inference_B1_CF2_Conv2D_layer_call_and_return_conditional_losses_6542

inputs8
conv2d_readvariableop_resource:
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:���������-C^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������-C: 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
�
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_6861

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
?__inference_FC-D1_layer_call_and_return_conditional_losses_8221

inputs0
matmul_readvariableop_resource:,
identity��MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:,*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������_
IdentityIdentityMatMul:product:0^NoOp*
T0*'
_output_shapes
:���������^
NoOpNoOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*(
_input_shapes
:���������,: 2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:���������,
 
_user_specified_nameinputs
�
f
H__inference_B1_CF2_Dropout_layer_call_and_return_conditional_losses_6557

inputs

identity_1V
IdentityIdentityinputs*
T0*/
_output_shapes
:���������-Cc

Identity_1IdentityIdentity:output:0*
T0*/
_output_shapes
:���������-C"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�	
�
/__inference_B3_CF1_BatchNorm_layer_call_fn_7349

inputs
unknown
	unknown_0: 
	unknown_1: 
	unknown_2: 
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+��������������������������� *%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_2352�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+��������������������������� `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+��������������������������� : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+��������������������������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
�
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_6484

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
f
-__inference_B1_CF1_Dropout_layer_call_fn_6381

inputs
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B1_CF1_Dropout_layer_call_and_return_conditional_losses_4356w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������-C`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
f
-__inference_B1_CF2_Dropout_layer_call_fn_6552

inputs
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B1_CF2_Dropout_layer_call_and_return_conditional_losses_4276w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������-C`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
n
R__inference_global_average_pooling2d_layer_call_and_return_conditional_losses_2633

inputs
identityg
Mean/reduction_indicesConst*
_output_shapes
:*
dtype0*
valueB"      p
MeanMeaninputsMean/reduction_indices:output:0*
T0*0
_output_shapes
:������������������^
IdentityIdentityMean:output:0*
T0*0
_output_shapes
:������������������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*I
_input_shapes8
6:4������������������������������������:r n
J
_output_shapes8
6:4������������������������������������
 
_user_specified_nameinputs
�
�
/__inference_B1_CF1_BatchNorm_layer_call_fn_6279

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_4405w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������-C`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������-C:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:
�
a
E__inference_B2_CF2_ReLu_layer_call_and_return_conditional_losses_2977

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:���������b
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_1956

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�e
1
__inference_call_1278

inputs
identityT
STFT/frame_lengthConst*
_output_shapes
: *
dtype0*
value
B :�Q
STFT/frame_stepConst*
_output_shapes
: *
dtype0*
value	B : R
STFT/fft_lengthConst*
_output_shapes
: *
dtype0*
value
B :�Z
STFT/frame/axisConst*
_output_shapes
: *
dtype0*
valueB :
���������F
STFT/frame/ShapeShapeinputs*
T0*
_output_shapes
:Q
STFT/frame/RankConst*
_output_shapes
: *
dtype0*
value	B :X
STFT/frame/range/startConst*
_output_shapes
: *
dtype0*
value	B : X
STFT/frame/range/deltaConst*
_output_shapes
: *
dtype0*
value	B :�
STFT/frame/rangeRangeSTFT/frame/range/start:output:0STFT/frame/Rank:output:0STFT/frame/range/delta:output:0*
_output_shapes
:q
STFT/frame/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
���������j
 STFT/frame/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: j
 STFT/frame/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:�
STFT/frame/strided_sliceStridedSliceSTFT/frame/range:output:0'STFT/frame/strided_slice/stack:output:0)STFT/frame/strided_slice/stack_1:output:0)STFT/frame/strided_slice/stack_2:output:0*
Index0*
T0*
_output_shapes
: *
shrink_axis_maskR
STFT/frame/sub/yConst*
_output_shapes
: *
dtype0*
value	B :k
STFT/frame/subSubSTFT/frame/Rank:output:0STFT/frame/sub/y:output:0*
T0*
_output_shapes
: o
STFT/frame/sub_1SubSTFT/frame/sub:z:0!STFT/frame/strided_slice:output:0*
T0*
_output_shapes
: U
STFT/frame/packed/1Const*
_output_shapes
: *
dtype0*
value	B :�
STFT/frame/packedPack!STFT/frame/strided_slice:output:0STFT/frame/packed/1:output:0STFT/frame/sub_1:z:0*
N*
T0*
_output_shapes
:\
STFT/frame/split/split_dimConst*
_output_shapes
: *
dtype0*
value	B : �
STFT/frame/splitSplitVSTFT/frame/Shape:output:0STFT/frame/packed:output:0#STFT/frame/split/split_dim:output:0*
T0*

Tlen0*$
_output_shapes
::: *
	num_split[
STFT/frame/Reshape/shapeConst*
_output_shapes
: *
dtype0*
valueB ]
STFT/frame/Reshape/shape_1Const*
_output_shapes
: *
dtype0*
valueB ~
STFT/frame/ReshapeReshapeSTFT/frame/split:output:1#STFT/frame/Reshape/shape_1:output:0*
T0*
_output_shapes
: Q
STFT/frame/SizeConst*
_output_shapes
: *
dtype0*
value	B :S
STFT/frame/Size_1Const*
_output_shapes
: *
dtype0*
value	B : q
STFT/frame/sub_2SubSTFT/frame/Reshape:output:0STFT/frame_length:output:0*
T0*
_output_shapes
: p
STFT/frame/floordivFloorDivSTFT/frame/sub_2:z:0STFT/frame_step:output:0*
T0*
_output_shapes
: R
STFT/frame/add/xConst*
_output_shapes
: *
dtype0*
value	B :l
STFT/frame/addAddV2STFT/frame/add/x:output:0STFT/frame/floordiv:z:0*
T0*
_output_shapes
: V
STFT/frame/Maximum/xConst*
_output_shapes
: *
dtype0*
value	B : q
STFT/frame/MaximumMaximumSTFT/frame/Maximum/x:output:0STFT/frame/add:z:0*
T0*
_output_shapes
: V
STFT/frame/gcd/ConstConst*
_output_shapes
: *
dtype0*
value	B : Y
STFT/frame/floordiv_1/yConst*
_output_shapes
: *
dtype0*
value	B : �
STFT/frame/floordiv_1FloorDivSTFT/frame_length:output:0 STFT/frame/floordiv_1/y:output:0*
T0*
_output_shapes
: Y
STFT/frame/floordiv_2/yConst*
_output_shapes
: *
dtype0*
value	B : ~
STFT/frame/floordiv_2FloorDivSTFT/frame_step:output:0 STFT/frame/floordiv_2/y:output:0*
T0*
_output_shapes
: Y
STFT/frame/floordiv_3/yConst*
_output_shapes
: *
dtype0*
value	B : �
STFT/frame/floordiv_3FloorDivSTFT/frame/Reshape:output:0 STFT/frame/floordiv_3/y:output:0*
T0*
_output_shapes
: R
STFT/frame/mul/yConst*
_output_shapes
: *
dtype0*
value	B : l
STFT/frame/mulMulSTFT/frame/floordiv_3:z:0STFT/frame/mul/y:output:0*
T0*
_output_shapes
: d
STFT/frame/concat/values_1PackSTFT/frame/mul:z:0*
N*
T0*
_output_shapes
:X
STFT/frame/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : �
STFT/frame/concatConcatV2STFT/frame/split:output:0#STFT/frame/concat/values_1:output:0STFT/frame/split:output:2STFT/frame/concat/axis:output:0*
N*
T0*
_output_shapes
:`
STFT/frame/concat_1/values_1/1Const*
_output_shapes
: *
dtype0*
value	B : �
STFT/frame/concat_1/values_1PackSTFT/frame/floordiv_3:z:0'STFT/frame/concat_1/values_1/1:output:0*
N*
T0*
_output_shapes
:Z
STFT/frame/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
STFT/frame/concat_1ConcatV2STFT/frame/split:output:0%STFT/frame/concat_1/values_1:output:0STFT/frame/split:output:2!STFT/frame/concat_1/axis:output:0*
N*
T0*
_output_shapes
:_
STFT/frame/zeros_likeConst*
_output_shapes
:*
dtype0*
valueB: d
STFT/frame/ones_like/ShapeConst*
_output_shapes
:*
dtype0*
valueB:\
STFT/frame/ones_like/ConstConst*
_output_shapes
: *
dtype0*
value	B :�
STFT/frame/ones_likeFill#STFT/frame/ones_like/Shape:output:0#STFT/frame/ones_like/Const:output:0*
T0*
_output_shapes
:�
STFT/frame/StridedSliceStridedSliceinputsSTFT/frame/zeros_like:output:0STFT/frame/concat:output:0STFT/frame/ones_like:output:0*
Index0*
T0*0
_output_shapes
:�������������������
STFT/frame/Reshape_1Reshape STFT/frame/StridedSlice:output:0STFT/frame/concat_1:output:0*
T0*4
_output_shapes"
 :������������������ Z
STFT/frame/range_1/startConst*
_output_shapes
: *
dtype0*
value	B : Z
STFT/frame/range_1/deltaConst*
_output_shapes
: *
dtype0*
value	B :�
STFT/frame/range_1Range!STFT/frame/range_1/start:output:0STFT/frame/Maximum:z:0!STFT/frame/range_1/delta:output:0*#
_output_shapes
:���������}
STFT/frame/mul_1MulSTFT/frame/range_1:output:0STFT/frame/floordiv_2:z:0*
T0*#
_output_shapes
:���������^
STFT/frame/Reshape_2/shape/1Const*
_output_shapes
: *
dtype0*
value	B :�
STFT/frame/Reshape_2/shapePackSTFT/frame/Maximum:z:0%STFT/frame/Reshape_2/shape/1:output:0*
N*
T0*
_output_shapes
:�
STFT/frame/Reshape_2ReshapeSTFT/frame/mul_1:z:0#STFT/frame/Reshape_2/shape:output:0*
T0*'
_output_shapes
:���������Z
STFT/frame/range_2/startConst*
_output_shapes
: *
dtype0*
value	B : Z
STFT/frame/range_2/deltaConst*
_output_shapes
: *
dtype0*
value	B :�
STFT/frame/range_2Range!STFT/frame/range_2/start:output:0STFT/frame/floordiv_1:z:0!STFT/frame/range_2/delta:output:0*
_output_shapes
:^
STFT/frame/Reshape_3/shape/0Const*
_output_shapes
: *
dtype0*
value	B :�
STFT/frame/Reshape_3/shapePack%STFT/frame/Reshape_3/shape/0:output:0STFT/frame/floordiv_1:z:0*
N*
T0*
_output_shapes
:�
STFT/frame/Reshape_3ReshapeSTFT/frame/range_2:output:0#STFT/frame/Reshape_3/shape:output:0*
T0*
_output_shapes

:�
STFT/frame/add_1AddV2STFT/frame/Reshape_2:output:0STFT/frame/Reshape_3:output:0*
T0*'
_output_shapes
:����������
STFT/frame/GatherV2GatherV2STFT/frame/Reshape_1:output:0STFT/frame/add_1:z:0!STFT/frame/strided_slice:output:0*
Taxis0*
Tindices0*
Tparams0*8
_output_shapes&
$:"������������������ �
STFT/frame/concat_2/values_1PackSTFT/frame/Maximum:z:0STFT/frame_length:output:0*
N*
T0*
_output_shapes
:Z
STFT/frame/concat_2/axisConst*
_output_shapes
: *
dtype0*
value	B : �
STFT/frame/concat_2ConcatV2STFT/frame/split:output:0%STFT/frame/concat_2/values_1:output:0STFT/frame/split:output:2!STFT/frame/concat_2/axis:output:0*
N*
T0*
_output_shapes
:�
STFT/frame/Reshape_4ReshapeSTFT/frame/GatherV2:output:0STFT/frame/concat_2:output:0*
T0*,
_output_shapes
:���������C�[
STFT/hann_window/periodicConst*
_output_shapes
: *
dtype0
*
value	B
 Z q
STFT/hann_window/CastCast"STFT/hann_window/periodic:output:0*

DstT0*

SrcT0
*
_output_shapes
: ]
STFT/hann_window/FloorMod/yConst*
_output_shapes
: *
dtype0*
value	B :�
STFT/hann_window/FloorModFloorModSTFT/frame_length:output:0$STFT/hann_window/FloorMod/y:output:0*
T0*
_output_shapes
: X
STFT/hann_window/sub/xConst*
_output_shapes
: *
dtype0*
value	B :|
STFT/hann_window/subSubSTFT/hann_window/sub/x:output:0STFT/hann_window/FloorMod:z:0*
T0*
_output_shapes
: q
STFT/hann_window/mulMulSTFT/hann_window/Cast:y:0STFT/hann_window/sub:z:0*
T0*
_output_shapes
: t
STFT/hann_window/addAddV2STFT/frame_length:output:0STFT/hann_window/mul:z:0*
T0*
_output_shapes
: Z
STFT/hann_window/sub_1/yConst*
_output_shapes
: *
dtype0*
value	B :{
STFT/hann_window/sub_1SubSTFT/hann_window/add:z:0!STFT/hann_window/sub_1/y:output:0*
T0*
_output_shapes
: k
STFT/hann_window/Cast_1CastSTFT/hann_window/sub_1:z:0*

DstT0*

SrcT0*
_output_shapes
: ^
STFT/hann_window/range/startConst*
_output_shapes
: *
dtype0*
value	B : ^
STFT/hann_window/range/deltaConst*
_output_shapes
: *
dtype0*
value	B :�
STFT/hann_window/rangeRange%STFT/hann_window/range/start:output:0STFT/frame_length:output:0%STFT/hann_window/range/delta:output:0*
_output_shapes	
:�u
STFT/hann_window/Cast_2CastSTFT/hann_window/range:output:0*

DstT0*

SrcT0*
_output_shapes	
:�[
STFT/hann_window/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *��@�
STFT/hann_window/mul_1MulSTFT/hann_window/Const:output:0STFT/hann_window/Cast_2:y:0*
T0*
_output_shapes	
:��
STFT/hann_window/truedivRealDivSTFT/hann_window/mul_1:z:0STFT/hann_window/Cast_1:y:0*
T0*
_output_shapes	
:�_
STFT/hann_window/CosCosSTFT/hann_window/truediv:z:0*
T0*
_output_shapes	
:�]
STFT/hann_window/mul_2/xConst*
_output_shapes
: *
dtype0*
valueB
 *   ?�
STFT/hann_window/mul_2Mul!STFT/hann_window/mul_2/x:output:0STFT/hann_window/Cos:y:0*
T0*
_output_shapes	
:�]
STFT/hann_window/sub_2/xConst*
_output_shapes
: *
dtype0*
valueB
 *   ?�
STFT/hann_window/sub_2Sub!STFT/hann_window/sub_2/x:output:0STFT/hann_window/mul_2:z:0*
T0*
_output_shapes	
:��
STFT/mulMulSTFT/frame/Reshape_4:output:0STFT/hann_window/sub_2:z:0*
T0*,
_output_shapes
:���������C�`
STFT/rfft/packedPackSTFT/fft_length:output:0*
N*
T0*
_output_shapes
:_
STFT/rfft/fft_lengthConst*
_output_shapes
:*
dtype0*
valueB:�k
	STFT/rfftRFFTSTFT/mul:z:0STFT/rfft/fft_length:output:0*+
_output_shapes
:���������CA�
PartitionedCallPartitionedCallSTFT/rfft:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������C-* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *!
fR
__inference__to_psd_1268J
ConstConst*
_output_shapes
: *
dtype0*
valueB
 *g��@J
add/yConst*
_output_shapes
: *
dtype0*
valueB
 *���.l
addAddV2PartitionedCall:output:0add/y:output:0*
T0*+
_output_shapes
:���������C-I
LogLogadd:z:0*
T0*+
_output_shapes
:���������C-Y
mulMulLog:y:0Const:output:0*
T0*+
_output_shapes
:���������C-o
transpose/permConst*
_output_shapes
:*
dtype0	*-
value$B"	"                      {
	transpose	Transposemul:z:0transpose/perm:output:0*
T0*
Tperm0	*+
_output_shapes
:���������-CY
IdentityIdentitytranspose:y:0*
T0*+
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*'
_input_shapes
:����������:P L
(
_output_shapes
:����������
 
_user_specified_nameinputs
�
�
'__inference_DenseNet_layer_call_fn_5505

inputs!
unknown:
	unknown_0
	unknown_1:
	unknown_2:
	unknown_3:#
	unknown_4:
	unknown_5
	unknown_6:
	unknown_7:
	unknown_8:#
	unknown_9:

unknown_10

unknown_11:

unknown_12:

unknown_13:$

unknown_14:

unknown_15

unknown_16:

unknown_17:

unknown_18:$

unknown_19:

unknown_20

unknown_21:

unknown_22:

unknown_23:$

unknown_24:

unknown_25

unknown_26: 

unknown_27: 

unknown_28: $

unknown_29:  

unknown_30

unknown_31: 

unknown_32: 

unknown_33: $

unknown_34: 

unknown_35

unknown_36:

unknown_37:

unknown_38:$

unknown_39:

unknown_40

unknown_41:(

unknown_42:(

unknown_43:($

unknown_44:((

unknown_45

unknown_46:(

unknown_47:(

unknown_48:($

unknown_49:(

unknown_50

unknown_51:,

unknown_52:,

unknown_53:,

unknown_54:,

unknown_55:

unknown_56:

unknown_57:

unknown_58:

unknown_59:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4	unknown_5	unknown_6	unknown_7	unknown_8	unknown_9
unknown_10
unknown_11
unknown_12
unknown_13
unknown_14
unknown_15
unknown_16
unknown_17
unknown_18
unknown_19
unknown_20
unknown_21
unknown_22
unknown_23
unknown_24
unknown_25
unknown_26
unknown_27
unknown_28
unknown_29
unknown_30
unknown_31
unknown_32
unknown_33
unknown_34
unknown_35
unknown_36
unknown_37
unknown_38
unknown_39
unknown_40
unknown_41
unknown_42
unknown_43
unknown_44
unknown_45
unknown_46
unknown_47
unknown_48
unknown_49
unknown_50
unknown_51
unknown_52
unknown_53
unknown_54
unknown_55
unknown_56
unknown_57
unknown_58
unknown_59*I
TinB
@2>*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*T
_read_only_resource_inputs6
42	
!"#$&'()+,-.012356789:;<=*-
config_proto

CPU

GPU 2J 8� *K
fFRD
B__inference_DenseNet_layer_call_and_return_conditional_losses_3373o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*�
_input_shapes�
�:���������-C: :: : : : :: : : : :: : : : :: : : : :: : : : : : : : : : : : : : :: : : : :(: : : : :(: : : : :,: : : : : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:S O
+
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
: :  

_output_shapes
: : %

_output_shapes
:: *

_output_shapes
:(: /

_output_shapes
:(: 4

_output_shapes
:,
�
F
*__inference_B1_CF2_ReLu_layer_call_fn_6523

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B1_CF2_ReLu_layer_call_and_return_conditional_losses_2806h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�

g
H__inference_B1_CF2_Dropout_layer_call_and_return_conditional_losses_4276

inputs
identity�R
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?l
dropout/MulMulinputsdropout/Const:output:0*
T0*/
_output_shapes
:���������-CC
dropout/ShapeShapeinputs*
T0*
_output_shapes
:�
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*/
_output_shapes
:���������-C*
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������-Cw
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������-Cq
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*/
_output_shapes
:���������-Ca
IdentityIdentitydropout/Mul_1:z:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�	
�
/__inference_B1_CF2_BatchNorm_layer_call_fn_6424

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+���������������������������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_2018�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
/__inference_B1_CF2_BatchNorm_layer_call_fn_6450

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_4325w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������-C`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������-C:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_3731

inputs	
scale%
readvariableop_resource:(6
(fusedbatchnormv3_readvariableop_resource:(8
*fusedbatchnormv3_readvariableop_1_resource:(
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������(:(:(:(:(:*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������(�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������(:(: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�
�
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_7066

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:����������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs: 

_output_shapes
:
�
]
A__inference_T2_Pool_layer_call_and_return_conditional_losses_2298

inputs
identity�
AvgPoolAvgPoolinputs*
T0*J
_output_shapes8
6:4������������������������������������*
ksize
*
paddingVALID*
strides
{
IdentityIdentityAvgPool:output:0*
T0*J
_output_shapes8
6:4������������������������������������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*I
_input_shapes8
6:4������������������������������������:r n
J
_output_shapes8
6:4������������������������������������
 
_user_specified_nameinputs
�
a
E__inference_B3_CF2_ReLu_layer_call_and_return_conditional_losses_7624

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:���������b
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
f
H__inference_B3_CF1_Dropout_layer_call_and_return_conditional_losses_3115

inputs

identity_1V
IdentityIdentityinputs*
T0*/
_output_shapes
:���������c

Identity_1IdentityIdentity:output:0*
T0*/
_output_shapes
:���������"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_1988

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
_
C__inference_rescaling_layer_call_and_return_conditional_losses_6213

inputs
identityK
Cast/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<M
Cast_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *  �?]
mulMulinputsCast/x:output:0*
T0*/
_output_shapes
:���������-Cb
addAddV2mul:z:0Cast_1/x:output:0*
T0*/
_output_shapes
:���������-CW
IdentityIdentityadd:z:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
�
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_7991

inputs	
scale%
readvariableop_resource:(6
(fusedbatchnormv3_readvariableop_resource:(8
*fusedbatchnormv3_readvariableop_1_resource:(
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������(:(:(:(:(:*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������(�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������(:(: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�

g
H__inference_B3_CF2_Dropout_layer_call_and_return_conditional_losses_7665

inputs
identity�R
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?l
dropout/MulMulinputsdropout/Const:output:0*
T0*/
_output_shapes
:���������C
dropout/ShapeShapeinputs*
T0*
_output_shapes
:�
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*/
_output_shapes
:���������*
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������w
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������q
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*/
_output_shapes
:���������a
IdentityIdentitydropout/Mul_1:z:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
f
H__inference_B1_CF1_Dropout_layer_call_and_return_conditional_losses_6386

inputs

identity_1V
IdentityIdentityinputs*
T0*/
_output_shapes
:���������-Cc

Identity_1IdentityIdentity:output:0*
T0*/
_output_shapes
:���������-C"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
I
-__inference_B4_CF1_Dropout_layer_call_fn_8020

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B4_CF1_Dropout_layer_call_and_return_conditional_losses_3286h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
M__inference_batch_normalization_layer_call_and_return_conditional_losses_8124

inputs	
scale%
readvariableop_resource:,6
(fusedbatchnormv3_readvariableop_resource:,8
*fusedbatchnormv3_readvariableop_1_resource:,
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:,*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:,*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:,*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������,:,:,:,:,:*
epsilon%��'7*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������,�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������,:,: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������,
 
_user_specified_nameinputs: 

_output_shapes
:,
�
f
H__inference_B3_CF2_Dropout_layer_call_and_return_conditional_losses_3166

inputs

identity_1V
IdentityIdentityinputs*
T0*/
_output_shapes
:���������c

Identity_1IdentityIdentity:output:0*
T0*/
_output_shapes
:���������"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
{
C__inference_B2_Concat_layer_call_and_return_conditional_losses_3005

inputs
inputs_1
inputs_2
identityM
concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
concatConcatV2inputsinputs_1inputs_2concat/axis:output:0*
N*
T0*/
_output_shapes
:��������� _
IdentityIdentityconcat:output:0*
T0*/
_output_shapes
:��������� "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*d
_input_shapesS
Q:���������:���������:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs:WS
/
_output_shapes
:���������
 
_user_specified_nameinputs:WS
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_4325

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������-C�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������-C:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_2018

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_2852

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������-C�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������-C:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:
��
�5
$__inference_with_transformation_1526

inputsJ
0densenet_pre_conv_conv2d_readvariableop_resource:#
densenet_b1_cf1_batchnorm_scale?
1densenet_b1_cf1_batchnorm_readvariableop_resource:P
Bdensenet_b1_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource:R
Ddensenet_b1_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource:O
5densenet_b1_cf1_conv2d_conv2d_readvariableop_resource:#
densenet_b1_cf2_batchnorm_scale?
1densenet_b1_cf2_batchnorm_readvariableop_resource:P
Bdensenet_b1_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource:R
Ddensenet_b1_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource:O
5densenet_b1_cf2_conv2d_conv2d_readvariableop_resource:"
densenet_t1_cf_batchnorm_scale>
0densenet_t1_cf_batchnorm_readvariableop_resource:O
Adensenet_t1_cf_batchnorm_fusedbatchnormv3_readvariableop_resource:Q
Cdensenet_t1_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource:N
4densenet_t1_cf_conv2d_conv2d_readvariableop_resource:#
densenet_b2_cf1_batchnorm_scale?
1densenet_b2_cf1_batchnorm_readvariableop_resource:P
Bdensenet_b2_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource:R
Ddensenet_b2_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource:O
5densenet_b2_cf1_conv2d_conv2d_readvariableop_resource:#
densenet_b2_cf2_batchnorm_scale?
1densenet_b2_cf2_batchnorm_readvariableop_resource:P
Bdensenet_b2_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource:R
Ddensenet_b2_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource:O
5densenet_b2_cf2_conv2d_conv2d_readvariableop_resource:"
densenet_t2_cf_batchnorm_scale>
0densenet_t2_cf_batchnorm_readvariableop_resource: O
Adensenet_t2_cf_batchnorm_fusedbatchnormv3_readvariableop_resource: Q
Cdensenet_t2_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource: N
4densenet_t2_cf_conv2d_conv2d_readvariableop_resource:  #
densenet_b3_cf1_batchnorm_scale?
1densenet_b3_cf1_batchnorm_readvariableop_resource: P
Bdensenet_b3_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource: R
Ddensenet_b3_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource: O
5densenet_b3_cf1_conv2d_conv2d_readvariableop_resource: #
densenet_b3_cf2_batchnorm_scale?
1densenet_b3_cf2_batchnorm_readvariableop_resource:P
Bdensenet_b3_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource:R
Ddensenet_b3_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource:O
5densenet_b3_cf2_conv2d_conv2d_readvariableop_resource:"
densenet_t3_cf_batchnorm_scale>
0densenet_t3_cf_batchnorm_readvariableop_resource:(O
Adensenet_t3_cf_batchnorm_fusedbatchnormv3_readvariableop_resource:(Q
Cdensenet_t3_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource:(N
4densenet_t3_cf_conv2d_conv2d_readvariableop_resource:((#
densenet_b4_cf1_batchnorm_scale?
1densenet_b4_cf1_batchnorm_readvariableop_resource:(P
Bdensenet_b4_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource:(R
Ddensenet_b4_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource:(O
5densenet_b4_cf1_conv2d_conv2d_readvariableop_resource:(&
"densenet_batch_normalization_scaleB
4densenet_batch_normalization_readvariableop_resource:,S
Edensenet_batch_normalization_fusedbatchnormv3_readvariableop_resource:,U
Gdensenet_batch_normalization_fusedbatchnormv3_readvariableop_1_resource:,?
-densenet_fc_d1_matmul_readvariableop_resource:,E
7densenet_batchnorm_d1_batchnorm_readvariableop_resource:G
9densenet_batchnorm_d1_batchnorm_readvariableop_1_resource:G
9densenet_batchnorm_d1_batchnorm_readvariableop_2_resource:@
.densenet_logits_matmul_readvariableop_resource:=
/densenet_logits_biasadd_readvariableop_resource:
identity��9DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B1_CF1_BatchNorm/ReadVariableOp�,DenseNet/B1_CF1_Conv2D/Conv2D/ReadVariableOp�9DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B1_CF2_BatchNorm/ReadVariableOp�,DenseNet/B1_CF2_Conv2D/Conv2D/ReadVariableOp�9DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B2_CF1_BatchNorm/ReadVariableOp�,DenseNet/B2_CF1_Conv2D/Conv2D/ReadVariableOp�9DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B2_CF2_BatchNorm/ReadVariableOp�,DenseNet/B2_CF2_Conv2D/Conv2D/ReadVariableOp�9DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B3_CF1_BatchNorm/ReadVariableOp�,DenseNet/B3_CF1_Conv2D/Conv2D/ReadVariableOp�9DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B3_CF2_BatchNorm/ReadVariableOp�,DenseNet/B3_CF2_Conv2D/Conv2D/ReadVariableOp�9DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B4_CF1_BatchNorm/ReadVariableOp�,DenseNet/B4_CF1_Conv2D/Conv2D/ReadVariableOp�.DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp�0DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_1�0DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_2�$DenseNet/FC-D1/MatMul/ReadVariableOp�&DenseNet/Logits/BiasAdd/ReadVariableOp�%DenseNet/Logits/MatMul/ReadVariableOp�'DenseNet/Pre_Conv/Conv2D/ReadVariableOp�8DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp�:DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�'DenseNet/T1_CF_BatchNorm/ReadVariableOp�+DenseNet/T1_CF_Conv2D/Conv2D/ReadVariableOp�8DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp�:DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�'DenseNet/T2_CF_BatchNorm/ReadVariableOp�+DenseNet/T2_CF_Conv2D/Conv2D/ReadVariableOp�8DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp�:DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�'DenseNet/T3_CF_BatchNorm/ReadVariableOp�+DenseNet/T3_CF_Conv2D/Conv2D/ReadVariableOp�<DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp�>DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp_1�+DenseNet/batch_normalization/ReadVariableOp�
normalize_audio/PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *(
_output_shapes
:����������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *
fR
__inference_call_1148�
audio2_spectral/PartitionedCallPartitionedCall(normalize_audio/PartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *
fR
__inference_call_1278h
&DenseNet/tf.expand_dims/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B :�
"DenseNet/tf.expand_dims/ExpandDims
ExpandDims(audio2_spectral/PartitionedCall:output:0/DenseNet/tf.expand_dims/ExpandDims/dim:output:0*
T0*/
_output_shapes
:���������-C^
DenseNet/rescaling/Cast/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<`
DenseNet/rescaling/Cast_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *  �?�
DenseNet/rescaling/mulMul+DenseNet/tf.expand_dims/ExpandDims:output:0"DenseNet/rescaling/Cast/x:output:0*
T0*/
_output_shapes
:���������-C�
DenseNet/rescaling/addAddV2DenseNet/rescaling/mul:z:0$DenseNet/rescaling/Cast_1/x:output:0*
T0*/
_output_shapes
:���������-C�
'DenseNet/Pre_Conv/Conv2D/ReadVariableOpReadVariableOp0densenet_pre_conv_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/Pre_Conv/Conv2DConv2DDenseNet/rescaling/add:z:0/DenseNet/Pre_Conv/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
�
(DenseNet/B1_CF1_BatchNorm/ReadVariableOpReadVariableOp1densenet_b1_cf1_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
9DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b1_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
;DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b1_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
*DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3FusedBatchNormV3!DenseNet/Pre_Conv/Conv2D:output:0densenet_b1_cf1_batchnorm_scale0DenseNet/B1_CF1_BatchNorm/ReadVariableOp:value:0ADenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( �
DenseNet/B1_CF1_ReLu/ReluRelu.DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������-C�
,DenseNet/B1_CF1_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b1_cf1_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/B1_CF1_Conv2D/Conv2DConv2D'DenseNet/B1_CF1_ReLu/Relu:activations:04DenseNet/B1_CF1_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
�
 DenseNet/B1_CF1_Dropout/IdentityIdentity&DenseNet/B1_CF1_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������-C�
(DenseNet/B1_CF2_BatchNorm/ReadVariableOpReadVariableOp1densenet_b1_cf2_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
9DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b1_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
;DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b1_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
*DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3FusedBatchNormV3)DenseNet/B1_CF1_Dropout/Identity:output:0densenet_b1_cf2_batchnorm_scale0DenseNet/B1_CF2_BatchNorm/ReadVariableOp:value:0ADenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( �
DenseNet/B1_CF2_ReLu/ReluRelu.DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������-C�
,DenseNet/B1_CF2_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b1_cf2_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/B1_CF2_Conv2D/Conv2DConv2D'DenseNet/B1_CF2_ReLu/Relu:activations:04DenseNet/B1_CF2_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
�
 DenseNet/B1_CF2_Dropout/IdentityIdentity&DenseNet/B1_CF2_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������-C`
DenseNet/B1_Concat/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
DenseNet/B1_Concat/concatConcatV2!DenseNet/Pre_Conv/Conv2D:output:0)DenseNet/B1_CF1_Dropout/Identity:output:0)DenseNet/B1_CF2_Dropout/Identity:output:0'DenseNet/B1_Concat/concat/axis:output:0*
N*
T0*/
_output_shapes
:���������-C�
'DenseNet/T1_CF_BatchNorm/ReadVariableOpReadVariableOp0densenet_t1_cf_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
8DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpAdensenet_t1_cf_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
:DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpCdensenet_t1_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
)DenseNet/T1_CF_BatchNorm/FusedBatchNormV3FusedBatchNormV3"DenseNet/B1_Concat/concat:output:0densenet_t1_cf_batchnorm_scale/DenseNet/T1_CF_BatchNorm/ReadVariableOp:value:0@DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0BDenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( �
DenseNet/T1_CF_ReLu/ReluRelu-DenseNet/T1_CF_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������-C�
+DenseNet/T1_CF_Conv2D/Conv2D/ReadVariableOpReadVariableOp4densenet_t1_cf_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/T1_CF_Conv2D/Conv2DConv2D&DenseNet/T1_CF_ReLu/Relu:activations:03DenseNet/T1_CF_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingVALID*
strides
�
DenseNet/T1_CF_Dropout/IdentityIdentity%DenseNet/T1_CF_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������-C�
&DenseNet/tf.compat.v1.pad/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
DenseNet/tf.compat.v1.pad/PadPad(DenseNet/T1_CF_Dropout/Identity:output:0/DenseNet/tf.compat.v1.pad/Pad/paddings:output:0*
T0*/
_output_shapes
:���������-E�
DenseNet/T1_Pool/AvgPoolAvgPool&DenseNet/tf.compat.v1.pad/Pad:output:0*
T0*/
_output_shapes
:���������*
ksize
*
paddingVALID*
strides
�
(DenseNet/B2_CF1_BatchNorm/ReadVariableOpReadVariableOp1densenet_b2_cf1_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
9DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b2_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
;DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b2_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
*DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3FusedBatchNormV3!DenseNet/T1_Pool/AvgPool:output:0densenet_b2_cf1_batchnorm_scale0DenseNet/B2_CF1_BatchNorm/ReadVariableOp:value:0ADenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( �
DenseNet/B2_CF1_ReLu/ReluRelu.DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:����������
,DenseNet/B2_CF1_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b2_cf1_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/B2_CF1_Conv2D/Conv2DConv2D'DenseNet/B2_CF1_ReLu/Relu:activations:04DenseNet/B2_CF1_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
�
 DenseNet/B2_CF1_Dropout/IdentityIdentity&DenseNet/B2_CF1_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:����������
(DenseNet/B2_CF2_BatchNorm/ReadVariableOpReadVariableOp1densenet_b2_cf2_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
9DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b2_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
;DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b2_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
*DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3FusedBatchNormV3)DenseNet/B2_CF1_Dropout/Identity:output:0densenet_b2_cf2_batchnorm_scale0DenseNet/B2_CF2_BatchNorm/ReadVariableOp:value:0ADenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( �
DenseNet/B2_CF2_ReLu/ReluRelu.DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:����������
,DenseNet/B2_CF2_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b2_cf2_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/B2_CF2_Conv2D/Conv2DConv2D'DenseNet/B2_CF2_ReLu/Relu:activations:04DenseNet/B2_CF2_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
�
 DenseNet/B2_CF2_Dropout/IdentityIdentity&DenseNet/B2_CF2_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������`
DenseNet/B2_Concat/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
DenseNet/B2_Concat/concatConcatV2!DenseNet/T1_Pool/AvgPool:output:0)DenseNet/B2_CF1_Dropout/Identity:output:0)DenseNet/B2_CF2_Dropout/Identity:output:0'DenseNet/B2_Concat/concat/axis:output:0*
N*
T0*/
_output_shapes
:��������� �
'DenseNet/T2_CF_BatchNorm/ReadVariableOpReadVariableOp0densenet_t2_cf_batchnorm_readvariableop_resource*
_output_shapes
: *
dtype0�
8DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpAdensenet_t2_cf_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
:DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpCdensenet_t2_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
)DenseNet/T2_CF_BatchNorm/FusedBatchNormV3FusedBatchNormV3"DenseNet/B2_Concat/concat:output:0densenet_t2_cf_batchnorm_scale/DenseNet/T2_CF_BatchNorm/ReadVariableOp:value:0@DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0BDenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:��������� : : : : :*
epsilon%o�:*
is_training( �
DenseNet/T2_CF_ReLu/ReluRelu-DenseNet/T2_CF_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:��������� �
+DenseNet/T2_CF_Conv2D/Conv2D/ReadVariableOpReadVariableOp4densenet_t2_cf_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:  *
dtype0�
DenseNet/T2_CF_Conv2D/Conv2DConv2D&DenseNet/T2_CF_ReLu/Relu:activations:03DenseNet/T2_CF_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:��������� *
paddingVALID*
strides
�
DenseNet/T2_CF_Dropout/IdentityIdentity%DenseNet/T2_CF_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:��������� �
(DenseNet/tf.compat.v1.pad_1/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
DenseNet/tf.compat.v1.pad_1/PadPad(DenseNet/T2_CF_Dropout/Identity:output:01DenseNet/tf.compat.v1.pad_1/Pad/paddings:output:0*
T0*/
_output_shapes
:��������� �
DenseNet/T2_Pool/AvgPoolAvgPool(DenseNet/tf.compat.v1.pad_1/Pad:output:0*
T0*/
_output_shapes
:��������� *
ksize
*
paddingVALID*
strides
�
(DenseNet/B3_CF1_BatchNorm/ReadVariableOpReadVariableOp1densenet_b3_cf1_batchnorm_readvariableop_resource*
_output_shapes
: *
dtype0�
9DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b3_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
;DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b3_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
*DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3FusedBatchNormV3!DenseNet/T2_Pool/AvgPool:output:0densenet_b3_cf1_batchnorm_scale0DenseNet/B3_CF1_BatchNorm/ReadVariableOp:value:0ADenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:��������� : : : : :*
epsilon%o�:*
is_training( �
DenseNet/B3_CF1_ReLu/ReluRelu.DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:��������� �
,DenseNet/B3_CF1_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b3_cf1_conv2d_conv2d_readvariableop_resource*&
_output_shapes
: *
dtype0�
DenseNet/B3_CF1_Conv2D/Conv2DConv2D'DenseNet/B3_CF1_ReLu/Relu:activations:04DenseNet/B3_CF1_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
�
 DenseNet/B3_CF1_Dropout/IdentityIdentity&DenseNet/B3_CF1_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:����������
(DenseNet/B3_CF2_BatchNorm/ReadVariableOpReadVariableOp1densenet_b3_cf2_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
9DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b3_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
;DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b3_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
*DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3FusedBatchNormV3)DenseNet/B3_CF1_Dropout/Identity:output:0densenet_b3_cf2_batchnorm_scale0DenseNet/B3_CF2_BatchNorm/ReadVariableOp:value:0ADenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( �
DenseNet/B3_CF2_ReLu/ReluRelu.DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:����������
,DenseNet/B3_CF2_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b3_cf2_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/B3_CF2_Conv2D/Conv2DConv2D'DenseNet/B3_CF2_ReLu/Relu:activations:04DenseNet/B3_CF2_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
�
 DenseNet/B3_CF2_Dropout/IdentityIdentity&DenseNet/B3_CF2_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������`
DenseNet/B3_Concat/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
DenseNet/B3_Concat/concatConcatV2!DenseNet/T2_Pool/AvgPool:output:0)DenseNet/B3_CF1_Dropout/Identity:output:0)DenseNet/B3_CF2_Dropout/Identity:output:0'DenseNet/B3_Concat/concat/axis:output:0*
N*
T0*/
_output_shapes
:���������(�
'DenseNet/T3_CF_BatchNorm/ReadVariableOpReadVariableOp0densenet_t3_cf_batchnorm_readvariableop_resource*
_output_shapes
:(*
dtype0�
8DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpAdensenet_t3_cf_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
:DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpCdensenet_t3_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
)DenseNet/T3_CF_BatchNorm/FusedBatchNormV3FusedBatchNormV3"DenseNet/B3_Concat/concat:output:0densenet_t3_cf_batchnorm_scale/DenseNet/T3_CF_BatchNorm/ReadVariableOp:value:0@DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0BDenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������(:(:(:(:(:*
epsilon%o�:*
is_training( �
DenseNet/T3_CF_ReLu/ReluRelu-DenseNet/T3_CF_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������(�
+DenseNet/T3_CF_Conv2D/Conv2D/ReadVariableOpReadVariableOp4densenet_t3_cf_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:((*
dtype0�
DenseNet/T3_CF_Conv2D/Conv2DConv2D&DenseNet/T3_CF_ReLu/Relu:activations:03DenseNet/T3_CF_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������(*
paddingVALID*
strides
�
DenseNet/T3_CF_Dropout/IdentityIdentity%DenseNet/T3_CF_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������(�
(DenseNet/tf.compat.v1.pad_2/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
DenseNet/tf.compat.v1.pad_2/PadPad(DenseNet/T3_CF_Dropout/Identity:output:01DenseNet/tf.compat.v1.pad_2/Pad/paddings:output:0*
T0*/
_output_shapes
:���������	(�
DenseNet/T3_Pool/AvgPoolAvgPool(DenseNet/tf.compat.v1.pad_2/Pad:output:0*
T0*/
_output_shapes
:���������(*
ksize
*
paddingVALID*
strides
�
(DenseNet/B4_CF1_BatchNorm/ReadVariableOpReadVariableOp1densenet_b4_cf1_batchnorm_readvariableop_resource*
_output_shapes
:(*
dtype0�
9DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b4_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
;DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b4_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
*DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3FusedBatchNormV3!DenseNet/T3_Pool/AvgPool:output:0densenet_b4_cf1_batchnorm_scale0DenseNet/B4_CF1_BatchNorm/ReadVariableOp:value:0ADenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������(:(:(:(:(:*
epsilon%o�:*
is_training( �
DenseNet/B4_CF1_ReLu/ReluRelu.DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������(�
,DenseNet/B4_CF1_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b4_cf1_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:(*
dtype0�
DenseNet/B4_CF1_Conv2D/Conv2DConv2D'DenseNet/B4_CF1_ReLu/Relu:activations:04DenseNet/B4_CF1_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
�
 DenseNet/B4_CF1_Dropout/IdentityIdentity&DenseNet/B4_CF1_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������`
DenseNet/B4_Concat/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
DenseNet/B4_Concat/concatConcatV2!DenseNet/T3_Pool/AvgPool:output:0)DenseNet/B4_CF1_Dropout/Identity:output:0'DenseNet/B4_Concat/concat/axis:output:0*
N*
T0*/
_output_shapes
:���������,�
+DenseNet/batch_normalization/ReadVariableOpReadVariableOp4densenet_batch_normalization_readvariableop_resource*
_output_shapes
:,*
dtype0�
<DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOpReadVariableOpEdensenet_batch_normalization_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:,*
dtype0�
>DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpGdensenet_batch_normalization_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:,*
dtype0�
-DenseNet/batch_normalization/FusedBatchNormV3FusedBatchNormV3"DenseNet/B4_Concat/concat:output:0"densenet_batch_normalization_scale3DenseNet/batch_normalization/ReadVariableOp:value:0DDenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp:value:0FDenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������,:,:,:,:,:*
epsilon%��'7*
is_training( �
DenseNet/ReLu/ReluRelu1DenseNet/batch_normalization/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������,�
8DenseNet/global_average_pooling2d/Mean/reduction_indicesConst*
_output_shapes
:*
dtype0*
valueB"      �
&DenseNet/global_average_pooling2d/MeanMean DenseNet/ReLu/Relu:activations:0ADenseNet/global_average_pooling2d/Mean/reduction_indices:output:0*
T0*'
_output_shapes
:���������,�
$DenseNet/FC-D1/MatMul/ReadVariableOpReadVariableOp-densenet_fc_d1_matmul_readvariableop_resource*
_output_shapes

:,*
dtype0�
DenseNet/FC-D1/MatMulMatMul/DenseNet/global_average_pooling2d/Mean:output:0,DenseNet/FC-D1/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:����������
.DenseNet/BatchNorm-D1/batchnorm/ReadVariableOpReadVariableOp7densenet_batchnorm_d1_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0j
%DenseNet/BatchNorm-D1/batchnorm/add/yConst*
_output_shapes
: *
dtype0*
valueB
 *w�+2�
#DenseNet/BatchNorm-D1/batchnorm/addAddV26DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp:value:0.DenseNet/BatchNorm-D1/batchnorm/add/y:output:0*
T0*
_output_shapes
:|
%DenseNet/BatchNorm-D1/batchnorm/RsqrtRsqrt'DenseNet/BatchNorm-D1/batchnorm/add:z:0*
T0*
_output_shapes
:�
#DenseNet/BatchNorm-D1/batchnorm/mulMulDenseNet/FC-D1/MatMul:product:0)DenseNet/BatchNorm-D1/batchnorm/Rsqrt:y:0*
T0*'
_output_shapes
:����������
0DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_1ReadVariableOp9densenet_batchnorm_d1_batchnorm_readvariableop_1_resource*
_output_shapes
:*
dtype0�
%DenseNet/BatchNorm-D1/batchnorm/mul_1Mul8DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_1:value:0)DenseNet/BatchNorm-D1/batchnorm/Rsqrt:y:0*
T0*
_output_shapes
:�
0DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_2ReadVariableOp9densenet_batchnorm_d1_batchnorm_readvariableop_2_resource*
_output_shapes
:*
dtype0�
#DenseNet/BatchNorm-D1/batchnorm/subSub8DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_2:value:0)DenseNet/BatchNorm-D1/batchnorm/mul_1:z:0*
T0*
_output_shapes
:�
%DenseNet/BatchNorm-D1/batchnorm/add_1AddV2'DenseNet/BatchNorm-D1/batchnorm/mul:z:0'DenseNet/BatchNorm-D1/batchnorm/sub:z:0*
T0*'
_output_shapes
:����������
%DenseNet/Logits/MatMul/ReadVariableOpReadVariableOp.densenet_logits_matmul_readvariableop_resource*
_output_shapes

:*
dtype0�
DenseNet/Logits/MatMulMatMul)DenseNet/BatchNorm-D1/batchnorm/add_1:z:0-DenseNet/Logits/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:����������
&DenseNet/Logits/BiasAdd/ReadVariableOpReadVariableOp/densenet_logits_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0�
DenseNet/Logits/BiasAddBiasAdd DenseNet/Logits/MatMul:product:0.DenseNet/Logits/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������v
DenseNet/Logits/SigmoidSigmoid DenseNet/Logits/BiasAdd:output:0*
T0*'
_output_shapes
:���������j
IdentityIdentityDenseNet/Logits/Sigmoid:y:0^NoOp*
T0*'
_output_shapes
:����������
NoOpNoOp:^DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B1_CF1_BatchNorm/ReadVariableOp-^DenseNet/B1_CF1_Conv2D/Conv2D/ReadVariableOp:^DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B1_CF2_BatchNorm/ReadVariableOp-^DenseNet/B1_CF2_Conv2D/Conv2D/ReadVariableOp:^DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B2_CF1_BatchNorm/ReadVariableOp-^DenseNet/B2_CF1_Conv2D/Conv2D/ReadVariableOp:^DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B2_CF2_BatchNorm/ReadVariableOp-^DenseNet/B2_CF2_Conv2D/Conv2D/ReadVariableOp:^DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B3_CF1_BatchNorm/ReadVariableOp-^DenseNet/B3_CF1_Conv2D/Conv2D/ReadVariableOp:^DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B3_CF2_BatchNorm/ReadVariableOp-^DenseNet/B3_CF2_Conv2D/Conv2D/ReadVariableOp:^DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B4_CF1_BatchNorm/ReadVariableOp-^DenseNet/B4_CF1_Conv2D/Conv2D/ReadVariableOp/^DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp1^DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_11^DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_2%^DenseNet/FC-D1/MatMul/ReadVariableOp'^DenseNet/Logits/BiasAdd/ReadVariableOp&^DenseNet/Logits/MatMul/ReadVariableOp(^DenseNet/Pre_Conv/Conv2D/ReadVariableOp9^DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp;^DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1(^DenseNet/T1_CF_BatchNorm/ReadVariableOp,^DenseNet/T1_CF_Conv2D/Conv2D/ReadVariableOp9^DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp;^DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1(^DenseNet/T2_CF_BatchNorm/ReadVariableOp,^DenseNet/T2_CF_Conv2D/Conv2D/ReadVariableOp9^DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp;^DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1(^DenseNet/T3_CF_BatchNorm/ReadVariableOp,^DenseNet/T3_CF_Conv2D/Conv2D/ReadVariableOp=^DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp?^DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp_1,^DenseNet/batch_normalization/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*�
_input_shapes�
�:����������: :: : : : :: : : : :: : : : :: : : : :: : : : : : : : : : : : : : :: : : : :(: : : : :(: : : : :,: : : : : : : : : 2v
9DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B1_CF1_BatchNorm/ReadVariableOp(DenseNet/B1_CF1_BatchNorm/ReadVariableOp2\
,DenseNet/B1_CF1_Conv2D/Conv2D/ReadVariableOp,DenseNet/B1_CF1_Conv2D/Conv2D/ReadVariableOp2v
9DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B1_CF2_BatchNorm/ReadVariableOp(DenseNet/B1_CF2_BatchNorm/ReadVariableOp2\
,DenseNet/B1_CF2_Conv2D/Conv2D/ReadVariableOp,DenseNet/B1_CF2_Conv2D/Conv2D/ReadVariableOp2v
9DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B2_CF1_BatchNorm/ReadVariableOp(DenseNet/B2_CF1_BatchNorm/ReadVariableOp2\
,DenseNet/B2_CF1_Conv2D/Conv2D/ReadVariableOp,DenseNet/B2_CF1_Conv2D/Conv2D/ReadVariableOp2v
9DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B2_CF2_BatchNorm/ReadVariableOp(DenseNet/B2_CF2_BatchNorm/ReadVariableOp2\
,DenseNet/B2_CF2_Conv2D/Conv2D/ReadVariableOp,DenseNet/B2_CF2_Conv2D/Conv2D/ReadVariableOp2v
9DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B3_CF1_BatchNorm/ReadVariableOp(DenseNet/B3_CF1_BatchNorm/ReadVariableOp2\
,DenseNet/B3_CF1_Conv2D/Conv2D/ReadVariableOp,DenseNet/B3_CF1_Conv2D/Conv2D/ReadVariableOp2v
9DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B3_CF2_BatchNorm/ReadVariableOp(DenseNet/B3_CF2_BatchNorm/ReadVariableOp2\
,DenseNet/B3_CF2_Conv2D/Conv2D/ReadVariableOp,DenseNet/B3_CF2_Conv2D/Conv2D/ReadVariableOp2v
9DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B4_CF1_BatchNorm/ReadVariableOp(DenseNet/B4_CF1_BatchNorm/ReadVariableOp2\
,DenseNet/B4_CF1_Conv2D/Conv2D/ReadVariableOp,DenseNet/B4_CF1_Conv2D/Conv2D/ReadVariableOp2`
.DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp.DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp2d
0DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_10DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_12d
0DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_20DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_22L
$DenseNet/FC-D1/MatMul/ReadVariableOp$DenseNet/FC-D1/MatMul/ReadVariableOp2P
&DenseNet/Logits/BiasAdd/ReadVariableOp&DenseNet/Logits/BiasAdd/ReadVariableOp2N
%DenseNet/Logits/MatMul/ReadVariableOp%DenseNet/Logits/MatMul/ReadVariableOp2R
'DenseNet/Pre_Conv/Conv2D/ReadVariableOp'DenseNet/Pre_Conv/Conv2D/ReadVariableOp2t
8DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp8DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2x
:DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_12R
'DenseNet/T1_CF_BatchNorm/ReadVariableOp'DenseNet/T1_CF_BatchNorm/ReadVariableOp2Z
+DenseNet/T1_CF_Conv2D/Conv2D/ReadVariableOp+DenseNet/T1_CF_Conv2D/Conv2D/ReadVariableOp2t
8DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp8DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2x
:DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_12R
'DenseNet/T2_CF_BatchNorm/ReadVariableOp'DenseNet/T2_CF_BatchNorm/ReadVariableOp2Z
+DenseNet/T2_CF_Conv2D/Conv2D/ReadVariableOp+DenseNet/T2_CF_Conv2D/Conv2D/ReadVariableOp2t
8DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp8DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2x
:DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_12R
'DenseNet/T3_CF_BatchNorm/ReadVariableOp'DenseNet/T3_CF_BatchNorm/ReadVariableOp2Z
+DenseNet/T3_CF_Conv2D/Conv2D/ReadVariableOp+DenseNet/T3_CF_Conv2D/Conv2D/ReadVariableOp2|
<DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp<DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp2�
>DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp_1>DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp_12Z
+DenseNet/batch_normalization/ReadVariableOp+DenseNet/batch_normalization/ReadVariableOp:P L
(
_output_shapes
:����������
 
_user_specified_nameinputs: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
: :  

_output_shapes
: : %

_output_shapes
:: *

_output_shapes
:(: /

_output_shapes
:(: 4

_output_shapes
:,
�
�
/__inference_B2_CF2_BatchNorm_layer_call_fn_6985

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_2962w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs: 

_output_shapes
:
�
I
-__inference_B2_CF2_Dropout_layer_call_fn_7095

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B2_CF2_Dropout_layer_call_and_return_conditional_losses_2995h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_2278

inputs	
scale%
readvariableop_resource: 6
(fusedbatchnormv3_readvariableop_resource: 8
*fusedbatchnormv3_readvariableop_1_resource: 
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+��������������������������� : : : : :*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+��������������������������� �
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+��������������������������� : : : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+��������������������������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
e
G__inference_T3_CF_Dropout_layer_call_and_return_conditional_losses_3227

inputs

identity_1V
IdentityIdentityinputs*
T0*/
_output_shapes
:���������(c

Identity_1IdentityIdentity:output:0*
T0*/
_output_shapes
:���������("!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������(:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs
�
�
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_2186

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
b
(__inference_B3_Concat_layer_call_fn_7672
inputs_0
inputs_1
inputs_2
identity�
PartitionedCallPartitionedCallinputs_0inputs_1inputs_2*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_B3_Concat_layer_call_and_return_conditional_losses_3176h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������("
identityIdentity:output:0*(
_construction_contextkEagerRuntime*d
_input_shapesS
Q:��������� :���������:���������:Y U
/
_output_shapes
:��������� 
"
_user_specified_name
inputs/0:YU
/
_output_shapes
:���������
"
_user_specified_name
inputs/1:YU
/
_output_shapes
:���������
"
_user_specified_name
inputs/2
�
1
__inference_call_1148

inputs
identitya
Mean/reduction_indicesConst*
_output_shapes
: *
dtype0*
valueB :
���������x
MeanMeaninputsMean/reduction_indices:output:0*
T0*'
_output_shapes
:���������*
	keep_dims(T
subSubinputsMean:output:0*
T0*(
_output_shapes
:����������F
AbsAbssub:z:0*
T0*(
_output_shapes
:����������`
Max/reduction_indicesConst*
_output_shapes
: *
dtype0*
valueB :
���������v
MaxMaxAbs:y:0Max/reduction_indices:output:0*
T0*'
_output_shapes
:���������*
	keep_dims(\
truedivRealDivsub:z:0Max:output:0*
T0*(
_output_shapes
:����������T
IdentityIdentitytruediv:z:0*
T0*(
_output_shapes
:����������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*'
_input_shapes
:����������:P L
(
_output_shapes
:����������
 
_user_specified_nameinputs
�
�
'__inference_Pre_Conv_layer_call_fn_6220

inputs!
unknown:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *K
fFRD
B__inference_Pre_Conv_layer_call_and_return_conditional_losses_2720w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������-C`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������-C: 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�	
�
2__inference_batch_normalization_layer_call_fn_8068

inputs
unknown
	unknown_0:,
	unknown_1:,
	unknown_2:,
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+���������������������������,*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *V
fQRO
M__inference_batch_normalization_layer_call_and_return_conditional_losses_2582�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������,`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������,:,: : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+���������������������������,
 
_user_specified_nameinputs: 

_output_shapes
:,
�h
�
__inference__traced_save_8483
file_prefix.
*savev2_pre_conv_kernel_read_readvariableop4
0savev2_b1_cf1_batchnorm_beta_read_readvariableop;
7savev2_b1_cf1_batchnorm_moving_mean_read_readvariableop?
;savev2_b1_cf1_batchnorm_moving_variance_read_readvariableop3
/savev2_b1_cf1_conv2d_kernel_read_readvariableop4
0savev2_b1_cf2_batchnorm_beta_read_readvariableop;
7savev2_b1_cf2_batchnorm_moving_mean_read_readvariableop?
;savev2_b1_cf2_batchnorm_moving_variance_read_readvariableop3
/savev2_b1_cf2_conv2d_kernel_read_readvariableop3
/savev2_t1_cf_batchnorm_beta_read_readvariableop:
6savev2_t1_cf_batchnorm_moving_mean_read_readvariableop>
:savev2_t1_cf_batchnorm_moving_variance_read_readvariableop2
.savev2_t1_cf_conv2d_kernel_read_readvariableop4
0savev2_b2_cf1_batchnorm_beta_read_readvariableop;
7savev2_b2_cf1_batchnorm_moving_mean_read_readvariableop?
;savev2_b2_cf1_batchnorm_moving_variance_read_readvariableop3
/savev2_b2_cf1_conv2d_kernel_read_readvariableop4
0savev2_b2_cf2_batchnorm_beta_read_readvariableop;
7savev2_b2_cf2_batchnorm_moving_mean_read_readvariableop?
;savev2_b2_cf2_batchnorm_moving_variance_read_readvariableop3
/savev2_b2_cf2_conv2d_kernel_read_readvariableop3
/savev2_t2_cf_batchnorm_beta_read_readvariableop:
6savev2_t2_cf_batchnorm_moving_mean_read_readvariableop>
:savev2_t2_cf_batchnorm_moving_variance_read_readvariableop2
.savev2_t2_cf_conv2d_kernel_read_readvariableop4
0savev2_b3_cf1_batchnorm_beta_read_readvariableop;
7savev2_b3_cf1_batchnorm_moving_mean_read_readvariableop?
;savev2_b3_cf1_batchnorm_moving_variance_read_readvariableop3
/savev2_b3_cf1_conv2d_kernel_read_readvariableop4
0savev2_b3_cf2_batchnorm_beta_read_readvariableop;
7savev2_b3_cf2_batchnorm_moving_mean_read_readvariableop?
;savev2_b3_cf2_batchnorm_moving_variance_read_readvariableop3
/savev2_b3_cf2_conv2d_kernel_read_readvariableop3
/savev2_t3_cf_batchnorm_beta_read_readvariableop:
6savev2_t3_cf_batchnorm_moving_mean_read_readvariableop>
:savev2_t3_cf_batchnorm_moving_variance_read_readvariableop2
.savev2_t3_cf_conv2d_kernel_read_readvariableop4
0savev2_b4_cf1_batchnorm_beta_read_readvariableop;
7savev2_b4_cf1_batchnorm_moving_mean_read_readvariableop?
;savev2_b4_cf1_batchnorm_moving_variance_read_readvariableop3
/savev2_b4_cf1_conv2d_kernel_read_readvariableop7
3savev2_batch_normalization_beta_read_readvariableop>
:savev2_batch_normalization_moving_mean_read_readvariableopB
>savev2_batch_normalization_moving_variance_read_readvariableop+
'savev2_fc_d1_kernel_read_readvariableop0
,savev2_batchnorm_d1_beta_read_readvariableop7
3savev2_batchnorm_d1_moving_mean_read_readvariableop;
7savev2_batchnorm_d1_moving_variance_read_readvariableop,
(savev2_logits_kernel_read_readvariableop*
&savev2_logits_bias_read_readvariableop
savev2_const_11

identity_1��MergeV2Checkpointsw
StaticRegexFullMatchStaticRegexFullMatchfile_prefix"/device:CPU:**
_output_shapes
: *
pattern
^s3://.*Z
ConstConst"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B.parta
Const_1Const"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B
_temp/part�
SelectSelectStaticRegexFullMatch:output:0Const:output:0Const_1:output:0"/device:CPU:**
T0*
_output_shapes
: f

StringJoin
StringJoinfile_prefixSelect:output:0"/device:CPU:**
N*
_output_shapes
: L

num_shardsConst*
_output_shapes
: *
dtype0*
value	B :f
ShardedFilename/shardConst"/device:CPU:0*
_output_shapes
: *
dtype0*
value	B : �
ShardedFilenameShardedFilenameStringJoin:output:0ShardedFilename/shard:output:0num_shards:output:0"/device:CPU:0*
_output_shapes
: �
SaveV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:3*
dtype0*�
value�B�3B<model/layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUEB:model/layer_with_weights-1/beta/.ATTRIBUTES/VARIABLE_VALUEBAmodel/layer_with_weights-1/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBEmodel/layer_with_weights-1/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB<model/layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUEB:model/layer_with_weights-3/beta/.ATTRIBUTES/VARIABLE_VALUEBAmodel/layer_with_weights-3/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBEmodel/layer_with_weights-3/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB<model/layer_with_weights-4/kernel/.ATTRIBUTES/VARIABLE_VALUEB:model/layer_with_weights-5/beta/.ATTRIBUTES/VARIABLE_VALUEBAmodel/layer_with_weights-5/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBEmodel/layer_with_weights-5/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB<model/layer_with_weights-6/kernel/.ATTRIBUTES/VARIABLE_VALUEB:model/layer_with_weights-7/beta/.ATTRIBUTES/VARIABLE_VALUEBAmodel/layer_with_weights-7/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBEmodel/layer_with_weights-7/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB<model/layer_with_weights-8/kernel/.ATTRIBUTES/VARIABLE_VALUEB:model/layer_with_weights-9/beta/.ATTRIBUTES/VARIABLE_VALUEBAmodel/layer_with_weights-9/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBEmodel/layer_with_weights-9/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB=model/layer_with_weights-10/kernel/.ATTRIBUTES/VARIABLE_VALUEB;model/layer_with_weights-11/beta/.ATTRIBUTES/VARIABLE_VALUEBBmodel/layer_with_weights-11/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBFmodel/layer_with_weights-11/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB=model/layer_with_weights-12/kernel/.ATTRIBUTES/VARIABLE_VALUEB;model/layer_with_weights-13/beta/.ATTRIBUTES/VARIABLE_VALUEBBmodel/layer_with_weights-13/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBFmodel/layer_with_weights-13/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB=model/layer_with_weights-14/kernel/.ATTRIBUTES/VARIABLE_VALUEB;model/layer_with_weights-15/beta/.ATTRIBUTES/VARIABLE_VALUEBBmodel/layer_with_weights-15/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBFmodel/layer_with_weights-15/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB=model/layer_with_weights-16/kernel/.ATTRIBUTES/VARIABLE_VALUEB;model/layer_with_weights-17/beta/.ATTRIBUTES/VARIABLE_VALUEBBmodel/layer_with_weights-17/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBFmodel/layer_with_weights-17/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB=model/layer_with_weights-18/kernel/.ATTRIBUTES/VARIABLE_VALUEB;model/layer_with_weights-19/beta/.ATTRIBUTES/VARIABLE_VALUEBBmodel/layer_with_weights-19/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBFmodel/layer_with_weights-19/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB=model/layer_with_weights-20/kernel/.ATTRIBUTES/VARIABLE_VALUEB;model/layer_with_weights-21/beta/.ATTRIBUTES/VARIABLE_VALUEBBmodel/layer_with_weights-21/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBFmodel/layer_with_weights-21/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB=model/layer_with_weights-22/kernel/.ATTRIBUTES/VARIABLE_VALUEB;model/layer_with_weights-23/beta/.ATTRIBUTES/VARIABLE_VALUEBBmodel/layer_with_weights-23/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBFmodel/layer_with_weights-23/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB=model/layer_with_weights-24/kernel/.ATTRIBUTES/VARIABLE_VALUEB;model/layer_with_weights-24/bias/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH�
SaveV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:3*
dtype0*y
valuepBn3B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B �
SaveV2SaveV2ShardedFilename:filename:0SaveV2/tensor_names:output:0 SaveV2/shape_and_slices:output:0*savev2_pre_conv_kernel_read_readvariableop0savev2_b1_cf1_batchnorm_beta_read_readvariableop7savev2_b1_cf1_batchnorm_moving_mean_read_readvariableop;savev2_b1_cf1_batchnorm_moving_variance_read_readvariableop/savev2_b1_cf1_conv2d_kernel_read_readvariableop0savev2_b1_cf2_batchnorm_beta_read_readvariableop7savev2_b1_cf2_batchnorm_moving_mean_read_readvariableop;savev2_b1_cf2_batchnorm_moving_variance_read_readvariableop/savev2_b1_cf2_conv2d_kernel_read_readvariableop/savev2_t1_cf_batchnorm_beta_read_readvariableop6savev2_t1_cf_batchnorm_moving_mean_read_readvariableop:savev2_t1_cf_batchnorm_moving_variance_read_readvariableop.savev2_t1_cf_conv2d_kernel_read_readvariableop0savev2_b2_cf1_batchnorm_beta_read_readvariableop7savev2_b2_cf1_batchnorm_moving_mean_read_readvariableop;savev2_b2_cf1_batchnorm_moving_variance_read_readvariableop/savev2_b2_cf1_conv2d_kernel_read_readvariableop0savev2_b2_cf2_batchnorm_beta_read_readvariableop7savev2_b2_cf2_batchnorm_moving_mean_read_readvariableop;savev2_b2_cf2_batchnorm_moving_variance_read_readvariableop/savev2_b2_cf2_conv2d_kernel_read_readvariableop/savev2_t2_cf_batchnorm_beta_read_readvariableop6savev2_t2_cf_batchnorm_moving_mean_read_readvariableop:savev2_t2_cf_batchnorm_moving_variance_read_readvariableop.savev2_t2_cf_conv2d_kernel_read_readvariableop0savev2_b3_cf1_batchnorm_beta_read_readvariableop7savev2_b3_cf1_batchnorm_moving_mean_read_readvariableop;savev2_b3_cf1_batchnorm_moving_variance_read_readvariableop/savev2_b3_cf1_conv2d_kernel_read_readvariableop0savev2_b3_cf2_batchnorm_beta_read_readvariableop7savev2_b3_cf2_batchnorm_moving_mean_read_readvariableop;savev2_b3_cf2_batchnorm_moving_variance_read_readvariableop/savev2_b3_cf2_conv2d_kernel_read_readvariableop/savev2_t3_cf_batchnorm_beta_read_readvariableop6savev2_t3_cf_batchnorm_moving_mean_read_readvariableop:savev2_t3_cf_batchnorm_moving_variance_read_readvariableop.savev2_t3_cf_conv2d_kernel_read_readvariableop0savev2_b4_cf1_batchnorm_beta_read_readvariableop7savev2_b4_cf1_batchnorm_moving_mean_read_readvariableop;savev2_b4_cf1_batchnorm_moving_variance_read_readvariableop/savev2_b4_cf1_conv2d_kernel_read_readvariableop3savev2_batch_normalization_beta_read_readvariableop:savev2_batch_normalization_moving_mean_read_readvariableop>savev2_batch_normalization_moving_variance_read_readvariableop'savev2_fc_d1_kernel_read_readvariableop,savev2_batchnorm_d1_beta_read_readvariableop3savev2_batchnorm_d1_moving_mean_read_readvariableop7savev2_batchnorm_d1_moving_variance_read_readvariableop(savev2_logits_kernel_read_readvariableop&savev2_logits_bias_read_readvariableopsavev2_const_11"/device:CPU:0*
_output_shapes
 *A
dtypes7
523�
&MergeV2Checkpoints/checkpoint_prefixesPackShardedFilename:filename:0^SaveV2"/device:CPU:0*
N*
T0*
_output_shapes
:�
MergeV2CheckpointsMergeV2Checkpoints/MergeV2Checkpoints/checkpoint_prefixes:output:0file_prefix"/device:CPU:0*
_output_shapes
 f
IdentityIdentityfile_prefix^MergeV2Checkpoints"/device:CPU:0*
T0*
_output_shapes
: Q

Identity_1IdentityIdentity:output:0^NoOp*
T0*
_output_shapes
: [
NoOpNoOp^MergeV2Checkpoints*"
_acd_function_control_output(*
_output_shapes
 "!

identity_1Identity_1:output:0*�
_input_shapes�
�: :::::::::::::::::::::: : : :  : : : : :::::(:(:(:((:(:(:(:(:,:,:,:,:::::: 2(
MergeV2CheckpointsMergeV2Checkpoints:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix:,(
&
_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
::,(
&
_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
::,	(
&
_output_shapes
:: 


_output_shapes
:: 

_output_shapes
:: 

_output_shapes
::,(
&
_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
::,(
&
_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
::,(
&
_output_shapes
:: 

_output_shapes
: : 

_output_shapes
: : 

_output_shapes
: :,(
&
_output_shapes
:  : 

_output_shapes
: : 

_output_shapes
: : 

_output_shapes
: :,(
&
_output_shapes
: : 

_output_shapes
:: 

_output_shapes
::  

_output_shapes
::,!(
&
_output_shapes
:: "

_output_shapes
:(: #

_output_shapes
:(: $

_output_shapes
:(:,%(
&
_output_shapes
:((: &

_output_shapes
:(: '

_output_shapes
:(: (

_output_shapes
:(:,)(
&
_output_shapes
:(: *

_output_shapes
:,: +

_output_shapes
:,: ,

_output_shapes
:,:$- 

_output_shapes

:,: .

_output_shapes
:: /

_output_shapes
:: 0

_output_shapes
::$1 

_output_shapes

:: 2

_output_shapes
::3

_output_shapes
: 
�
B
&__inference_T3_Pool_layer_call_fn_7856

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *J
_output_shapes8
6:4������������������������������������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *J
fERC
A__inference_T3_Pool_layer_call_and_return_conditional_losses_2496�
IdentityIdentityPartitionedCall:output:0*
T0*J
_output_shapes8
6:4������������������������������������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*I
_input_shapes8
6:4������������������������������������:r n
J
_output_shapes8
6:4������������������������������������
 
_user_specified_nameinputs
�
f
H__inference_B2_CF2_Dropout_layer_call_and_return_conditional_losses_7105

inputs

identity_1V
IdentityIdentityinputs*
T0*/
_output_shapes
:���������c

Identity_1IdentityIdentity:output:0*
T0*/
_output_shapes
:���������"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
/__inference_B3_CF1_BatchNorm_layer_call_fn_7362

inputs
unknown
	unknown_0: 
	unknown_1: 
	unknown_2: 
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� *%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_3082w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:��������� `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':��������� : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
�
F__inference_BatchNorm-D1_layer_call_and_return_conditional_losses_8277

inputs/
!batchnorm_readvariableop_resource:1
#batchnorm_readvariableop_1_resource:1
#batchnorm_readvariableop_2_resource:
identity��batchnorm/ReadVariableOp�batchnorm/ReadVariableOp_1�batchnorm/ReadVariableOp_2v
batchnorm/ReadVariableOpReadVariableOp!batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0T
batchnorm/add/yConst*
_output_shapes
: *
dtype0*
valueB
 *w�+2w
batchnorm/addAddV2 batchnorm/ReadVariableOp:value:0batchnorm/add/y:output:0*
T0*
_output_shapes
:P
batchnorm/RsqrtRsqrtbatchnorm/add:z:0*
T0*
_output_shapes
:c
batchnorm/mulMulinputsbatchnorm/Rsqrt:y:0*
T0*'
_output_shapes
:���������z
batchnorm/ReadVariableOp_1ReadVariableOp#batchnorm_readvariableop_1_resource*
_output_shapes
:*
dtype0t
batchnorm/mul_1Mul"batchnorm/ReadVariableOp_1:value:0batchnorm/Rsqrt:y:0*
T0*
_output_shapes
:z
batchnorm/ReadVariableOp_2ReadVariableOp#batchnorm_readvariableop_2_resource*
_output_shapes
:*
dtype0r
batchnorm/subSub"batchnorm/ReadVariableOp_2:value:0batchnorm/mul_1:z:0*
T0*
_output_shapes
:p
batchnorm/add_1AddV2batchnorm/mul:z:0batchnorm/sub:z:0*
T0*'
_output_shapes
:���������b
IdentityIdentitybatchnorm/add_1:z:0^NoOp*
T0*'
_output_shapes
:����������
NoOpNoOp^batchnorm/ReadVariableOp^batchnorm/ReadVariableOp_1^batchnorm/ReadVariableOp_2*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*,
_input_shapes
:���������: : : 24
batchnorm/ReadVariableOpbatchnorm/ReadVariableOp28
batchnorm/ReadVariableOp_1batchnorm/ReadVariableOp_128
batchnorm/ReadVariableOp_2batchnorm/ReadVariableOp_2:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
%__inference_Logits_layer_call_fn_8286

inputs
unknown:
	unknown_0:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *I
fDRB
@__inference_Logits_layer_call_and_return_conditional_losses_3366o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime**
_input_shapes
:���������: : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_2216

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
G__inference_B4_CF1_Conv2D_layer_call_and_return_conditional_losses_8015

inputs8
conv2d_readvariableop_resource:(
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
:(*
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:���������^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������(: 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs
�
�
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_6895

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:����������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_6347

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������-C�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������-C:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
/__inference_B3_CF2_BatchNorm_layer_call_fn_7533

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_3133w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs: 

_output_shapes
:
�
f
-__inference_B4_CF1_Dropout_layer_call_fn_8025

inputs
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B4_CF1_Dropout_layer_call_and_return_conditional_losses_3597w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
n
R__inference_global_average_pooling2d_layer_call_and_return_conditional_losses_8207

inputs
identityg
Mean/reduction_indicesConst*
_output_shapes
:*
dtype0*
valueB"      g
MeanMeaninputsMean/reduction_indices:output:0*
T0*'
_output_shapes
:���������,U
IdentityIdentityMean:output:0*
T0*'
_output_shapes
:���������,"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������,:W S
/
_output_shapes
:���������,
 
_user_specified_nameinputs
�
Z
>__inference_ReLu_layer_call_and_return_conditional_losses_3328

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:���������,b
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:���������,"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������,:W S
/
_output_shapes
:���������,
 
_user_specified_nameinputs
�
�
,__inference_B2_CF2_Conv2D_layer_call_fn_7083

inputs!
unknown:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B2_CF2_Conv2D_layer_call_and_return_conditional_losses_2986w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������: 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
F__inference_T2_CF_Conv2D_layer_call_and_return_conditional_losses_3047

inputs8
conv2d_readvariableop_resource:  
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
:  *
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:��������� *
paddingVALID*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:��������� ^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:��������� : 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
�

g
H__inference_B3_CF2_Dropout_layer_call_and_return_conditional_losses_3770

inputs
identity�R
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?l
dropout/MulMulinputsdropout/Const:output:0*
T0*/
_output_shapes
:���������C
dropout/ShapeShapeinputs*
T0*
_output_shapes
:�
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*/
_output_shapes
:���������*
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������w
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������q
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*/
_output_shapes
:���������a
IdentityIdentitydropout/Mul_1:z:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
a
E__inference_B1_CF1_ReLu_layer_call_and_return_conditional_losses_2755

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:���������-Cb
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
f
H__inference_B3_CF2_Dropout_layer_call_and_return_conditional_losses_7653

inputs

identity_1V
IdentityIdentityinputs*
T0*/
_output_shapes
:���������c

Identity_1IdentityIdentity:output:0*
T0*/
_output_shapes
:���������"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
B
&__inference_T1_Pool_layer_call_fn_6760

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *J
_output_shapes8
6:4������������������������������������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *J
fERC
A__inference_T1_Pool_layer_call_and_return_conditional_losses_2100�
IdentityIdentityPartitionedCall:output:0*
T0*J
_output_shapes8
6:4������������������������������������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*I
_input_shapes8
6:4������������������������������������:r n
J
_output_shapes8
6:4������������������������������������
 
_user_specified_nameinputs
�
f
-__inference_B2_CF2_Dropout_layer_call_fn_7100

inputs
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B2_CF2_Dropout_layer_call_and_return_conditional_losses_4023w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
G__inference_B3_CF1_Conv2D_layer_call_and_return_conditional_losses_7467

inputs8
conv2d_readvariableop_resource: 
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
: *
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:���������^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:��������� : 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
�
e
,__inference_T1_CF_Dropout_layer_call_fn_6738

inputs
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_T1_CF_Dropout_layer_call_and_return_conditional_losses_4188w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������-C`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
e
G__inference_T2_CF_Dropout_layer_call_and_return_conditional_losses_3056

inputs

identity_1V
IdentityIdentityinputs*
T0*/
_output_shapes
:��������� c

Identity_1IdentityIdentity:output:0*
T0*/
_output_shapes
:��������� "!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:��������� :W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
�	
�
.__inference_T1_CF_BatchNorm_layer_call_fn_6597

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+���������������������������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_2050�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�

f
G__inference_T3_CF_Dropout_layer_call_and_return_conditional_losses_7851

inputs
identity�R
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?l
dropout/MulMulinputsdropout/Const:output:0*
T0*/
_output_shapes
:���������(C
dropout/ShapeShapeinputs*
T0*
_output_shapes
:�
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*/
_output_shapes
:���������(*
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������(w
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������(q
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*/
_output_shapes
:���������(a
IdentityIdentitydropout/Mul_1:z:0*
T0*/
_output_shapes
:���������("
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������(:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs
�
f
H__inference_B4_CF1_Dropout_layer_call_and_return_conditional_losses_3286

inputs

identity_1V
IdentityIdentityinputs*
T0*/
_output_shapes
:���������c

Identity_1IdentityIdentity:output:0*
T0*/
_output_shapes
:���������"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
F
*__inference_B2_CF1_ReLu_layer_call_fn_6900

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B2_CF1_ReLu_layer_call_and_return_conditional_losses_2926h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
B__inference_Pre_Conv_layer_call_and_return_conditional_losses_6227

inputs8
conv2d_readvariableop_resource:
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:���������-C^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������-C: 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
�
'__inference_DenseNet_layer_call_fn_3498
input_1!
unknown:
	unknown_0
	unknown_1:
	unknown_2:
	unknown_3:#
	unknown_4:
	unknown_5
	unknown_6:
	unknown_7:
	unknown_8:#
	unknown_9:

unknown_10

unknown_11:

unknown_12:

unknown_13:$

unknown_14:

unknown_15

unknown_16:

unknown_17:

unknown_18:$

unknown_19:

unknown_20

unknown_21:

unknown_22:

unknown_23:$

unknown_24:

unknown_25

unknown_26: 

unknown_27: 

unknown_28: $

unknown_29:  

unknown_30

unknown_31: 

unknown_32: 

unknown_33: $

unknown_34: 

unknown_35

unknown_36:

unknown_37:

unknown_38:$

unknown_39:

unknown_40

unknown_41:(

unknown_42:(

unknown_43:($

unknown_44:((

unknown_45

unknown_46:(

unknown_47:(

unknown_48:($

unknown_49:(

unknown_50

unknown_51:,

unknown_52:,

unknown_53:,

unknown_54:,

unknown_55:

unknown_56:

unknown_57:

unknown_58:

unknown_59:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinput_1unknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4	unknown_5	unknown_6	unknown_7	unknown_8	unknown_9
unknown_10
unknown_11
unknown_12
unknown_13
unknown_14
unknown_15
unknown_16
unknown_17
unknown_18
unknown_19
unknown_20
unknown_21
unknown_22
unknown_23
unknown_24
unknown_25
unknown_26
unknown_27
unknown_28
unknown_29
unknown_30
unknown_31
unknown_32
unknown_33
unknown_34
unknown_35
unknown_36
unknown_37
unknown_38
unknown_39
unknown_40
unknown_41
unknown_42
unknown_43
unknown_44
unknown_45
unknown_46
unknown_47
unknown_48
unknown_49
unknown_50
unknown_51
unknown_52
unknown_53
unknown_54
unknown_55
unknown_56
unknown_57
unknown_58
unknown_59*I
TinB
@2>*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*T
_read_only_resource_inputs6
42	
!"#$&'()+,-.012356789:;<=*-
config_proto

CPU

GPU 2J 8� *K
fFRD
B__inference_DenseNet_layer_call_and_return_conditional_losses_3373o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*�
_input_shapes�
�:���������-C: :: : : : :: : : : :: : : : :: : : : :: : : : : : : : : : : : : : :: : : : :(: : : : :(: : : : :,: : : : : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:T P
+
_output_shapes
:���������-C
!
_user_specified_name	input_1: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
: :  

_output_shapes
: : %

_output_shapes
:: *

_output_shapes
:(: /

_output_shapes
:(: 4

_output_shapes
:,
�	
�
/__inference_B2_CF2_BatchNorm_layer_call_fn_6972

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+���������������������������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_2216�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
M__inference_batch_normalization_layer_call_and_return_conditional_losses_8158

inputs	
scale%
readvariableop_resource:,6
(fusedbatchnormv3_readvariableop_resource:,8
*fusedbatchnormv3_readvariableop_1_resource:,
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:,*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:,*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:,*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������,:,:,:,:,:*
epsilon%��'7*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������,�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������,:,: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������,
 
_user_specified_nameinputs: 

_output_shapes
:,
�
H
,__inference_T1_CF_Dropout_layer_call_fn_6733

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_T1_CF_Dropout_layer_call_and_return_conditional_losses_2885h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
}
C__inference_B1_Concat_layer_call_and_return_conditional_losses_6584
inputs_0
inputs_1
inputs_2
identityM
concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
concatConcatV2inputs_0inputs_1inputs_2concat/axis:output:0*
N*
T0*/
_output_shapes
:���������-C_
IdentityIdentityconcat:output:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*d
_input_shapesS
Q:���������-C:���������-C:���������-C:Y U
/
_output_shapes
:���������-C
"
_user_specified_name
inputs/0:YU
/
_output_shapes
:���������-C
"
_user_specified_name
inputs/1:YU
/
_output_shapes
:���������-C
"
_user_specified_name
inputs/2
�
�
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_2384

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
a
E__inference_B3_CF1_ReLu_layer_call_and_return_conditional_losses_3097

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:��������� b
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:��������� "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:��������� :W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
��
�!
 __inference__traced_restore_8643
file_prefix:
 assignvariableop_pre_conv_kernel:6
(assignvariableop_1_b1_cf1_batchnorm_beta:=
/assignvariableop_2_b1_cf1_batchnorm_moving_mean:A
3assignvariableop_3_b1_cf1_batchnorm_moving_variance:A
'assignvariableop_4_b1_cf1_conv2d_kernel:6
(assignvariableop_5_b1_cf2_batchnorm_beta:=
/assignvariableop_6_b1_cf2_batchnorm_moving_mean:A
3assignvariableop_7_b1_cf2_batchnorm_moving_variance:A
'assignvariableop_8_b1_cf2_conv2d_kernel:5
'assignvariableop_9_t1_cf_batchnorm_beta:=
/assignvariableop_10_t1_cf_batchnorm_moving_mean:A
3assignvariableop_11_t1_cf_batchnorm_moving_variance:A
'assignvariableop_12_t1_cf_conv2d_kernel:7
)assignvariableop_13_b2_cf1_batchnorm_beta:>
0assignvariableop_14_b2_cf1_batchnorm_moving_mean:B
4assignvariableop_15_b2_cf1_batchnorm_moving_variance:B
(assignvariableop_16_b2_cf1_conv2d_kernel:7
)assignvariableop_17_b2_cf2_batchnorm_beta:>
0assignvariableop_18_b2_cf2_batchnorm_moving_mean:B
4assignvariableop_19_b2_cf2_batchnorm_moving_variance:B
(assignvariableop_20_b2_cf2_conv2d_kernel:6
(assignvariableop_21_t2_cf_batchnorm_beta: =
/assignvariableop_22_t2_cf_batchnorm_moving_mean: A
3assignvariableop_23_t2_cf_batchnorm_moving_variance: A
'assignvariableop_24_t2_cf_conv2d_kernel:  7
)assignvariableop_25_b3_cf1_batchnorm_beta: >
0assignvariableop_26_b3_cf1_batchnorm_moving_mean: B
4assignvariableop_27_b3_cf1_batchnorm_moving_variance: B
(assignvariableop_28_b3_cf1_conv2d_kernel: 7
)assignvariableop_29_b3_cf2_batchnorm_beta:>
0assignvariableop_30_b3_cf2_batchnorm_moving_mean:B
4assignvariableop_31_b3_cf2_batchnorm_moving_variance:B
(assignvariableop_32_b3_cf2_conv2d_kernel:6
(assignvariableop_33_t3_cf_batchnorm_beta:(=
/assignvariableop_34_t3_cf_batchnorm_moving_mean:(A
3assignvariableop_35_t3_cf_batchnorm_moving_variance:(A
'assignvariableop_36_t3_cf_conv2d_kernel:((7
)assignvariableop_37_b4_cf1_batchnorm_beta:(>
0assignvariableop_38_b4_cf1_batchnorm_moving_mean:(B
4assignvariableop_39_b4_cf1_batchnorm_moving_variance:(B
(assignvariableop_40_b4_cf1_conv2d_kernel:(:
,assignvariableop_41_batch_normalization_beta:,A
3assignvariableop_42_batch_normalization_moving_mean:,E
7assignvariableop_43_batch_normalization_moving_variance:,2
 assignvariableop_44_fc_d1_kernel:,3
%assignvariableop_45_batchnorm_d1_beta::
,assignvariableop_46_batchnorm_d1_moving_mean:>
0assignvariableop_47_batchnorm_d1_moving_variance:3
!assignvariableop_48_logits_kernel:-
assignvariableop_49_logits_bias:
identity_51��AssignVariableOp�AssignVariableOp_1�AssignVariableOp_10�AssignVariableOp_11�AssignVariableOp_12�AssignVariableOp_13�AssignVariableOp_14�AssignVariableOp_15�AssignVariableOp_16�AssignVariableOp_17�AssignVariableOp_18�AssignVariableOp_19�AssignVariableOp_2�AssignVariableOp_20�AssignVariableOp_21�AssignVariableOp_22�AssignVariableOp_23�AssignVariableOp_24�AssignVariableOp_25�AssignVariableOp_26�AssignVariableOp_27�AssignVariableOp_28�AssignVariableOp_29�AssignVariableOp_3�AssignVariableOp_30�AssignVariableOp_31�AssignVariableOp_32�AssignVariableOp_33�AssignVariableOp_34�AssignVariableOp_35�AssignVariableOp_36�AssignVariableOp_37�AssignVariableOp_38�AssignVariableOp_39�AssignVariableOp_4�AssignVariableOp_40�AssignVariableOp_41�AssignVariableOp_42�AssignVariableOp_43�AssignVariableOp_44�AssignVariableOp_45�AssignVariableOp_46�AssignVariableOp_47�AssignVariableOp_48�AssignVariableOp_49�AssignVariableOp_5�AssignVariableOp_6�AssignVariableOp_7�AssignVariableOp_8�AssignVariableOp_9�
RestoreV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:3*
dtype0*�
value�B�3B<model/layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUEB:model/layer_with_weights-1/beta/.ATTRIBUTES/VARIABLE_VALUEBAmodel/layer_with_weights-1/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBEmodel/layer_with_weights-1/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB<model/layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUEB:model/layer_with_weights-3/beta/.ATTRIBUTES/VARIABLE_VALUEBAmodel/layer_with_weights-3/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBEmodel/layer_with_weights-3/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB<model/layer_with_weights-4/kernel/.ATTRIBUTES/VARIABLE_VALUEB:model/layer_with_weights-5/beta/.ATTRIBUTES/VARIABLE_VALUEBAmodel/layer_with_weights-5/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBEmodel/layer_with_weights-5/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB<model/layer_with_weights-6/kernel/.ATTRIBUTES/VARIABLE_VALUEB:model/layer_with_weights-7/beta/.ATTRIBUTES/VARIABLE_VALUEBAmodel/layer_with_weights-7/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBEmodel/layer_with_weights-7/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB<model/layer_with_weights-8/kernel/.ATTRIBUTES/VARIABLE_VALUEB:model/layer_with_weights-9/beta/.ATTRIBUTES/VARIABLE_VALUEBAmodel/layer_with_weights-9/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBEmodel/layer_with_weights-9/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB=model/layer_with_weights-10/kernel/.ATTRIBUTES/VARIABLE_VALUEB;model/layer_with_weights-11/beta/.ATTRIBUTES/VARIABLE_VALUEBBmodel/layer_with_weights-11/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBFmodel/layer_with_weights-11/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB=model/layer_with_weights-12/kernel/.ATTRIBUTES/VARIABLE_VALUEB;model/layer_with_weights-13/beta/.ATTRIBUTES/VARIABLE_VALUEBBmodel/layer_with_weights-13/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBFmodel/layer_with_weights-13/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB=model/layer_with_weights-14/kernel/.ATTRIBUTES/VARIABLE_VALUEB;model/layer_with_weights-15/beta/.ATTRIBUTES/VARIABLE_VALUEBBmodel/layer_with_weights-15/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBFmodel/layer_with_weights-15/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB=model/layer_with_weights-16/kernel/.ATTRIBUTES/VARIABLE_VALUEB;model/layer_with_weights-17/beta/.ATTRIBUTES/VARIABLE_VALUEBBmodel/layer_with_weights-17/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBFmodel/layer_with_weights-17/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB=model/layer_with_weights-18/kernel/.ATTRIBUTES/VARIABLE_VALUEB;model/layer_with_weights-19/beta/.ATTRIBUTES/VARIABLE_VALUEBBmodel/layer_with_weights-19/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBFmodel/layer_with_weights-19/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB=model/layer_with_weights-20/kernel/.ATTRIBUTES/VARIABLE_VALUEB;model/layer_with_weights-21/beta/.ATTRIBUTES/VARIABLE_VALUEBBmodel/layer_with_weights-21/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBFmodel/layer_with_weights-21/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB=model/layer_with_weights-22/kernel/.ATTRIBUTES/VARIABLE_VALUEB;model/layer_with_weights-23/beta/.ATTRIBUTES/VARIABLE_VALUEBBmodel/layer_with_weights-23/moving_mean/.ATTRIBUTES/VARIABLE_VALUEBFmodel/layer_with_weights-23/moving_variance/.ATTRIBUTES/VARIABLE_VALUEB=model/layer_with_weights-24/kernel/.ATTRIBUTES/VARIABLE_VALUEB;model/layer_with_weights-24/bias/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH�
RestoreV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:3*
dtype0*y
valuepBn3B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B �
	RestoreV2	RestoreV2file_prefixRestoreV2/tensor_names:output:0#RestoreV2/shape_and_slices:output:0"/device:CPU:0*�
_output_shapes�
�:::::::::::::::::::::::::::::::::::::::::::::::::::*A
dtypes7
523[
IdentityIdentityRestoreV2:tensors:0"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOpAssignVariableOp assignvariableop_pre_conv_kernelIdentity:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_1IdentityRestoreV2:tensors:1"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_1AssignVariableOp(assignvariableop_1_b1_cf1_batchnorm_betaIdentity_1:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_2IdentityRestoreV2:tensors:2"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_2AssignVariableOp/assignvariableop_2_b1_cf1_batchnorm_moving_meanIdentity_2:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_3IdentityRestoreV2:tensors:3"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_3AssignVariableOp3assignvariableop_3_b1_cf1_batchnorm_moving_varianceIdentity_3:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_4IdentityRestoreV2:tensors:4"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_4AssignVariableOp'assignvariableop_4_b1_cf1_conv2d_kernelIdentity_4:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_5IdentityRestoreV2:tensors:5"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_5AssignVariableOp(assignvariableop_5_b1_cf2_batchnorm_betaIdentity_5:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_6IdentityRestoreV2:tensors:6"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_6AssignVariableOp/assignvariableop_6_b1_cf2_batchnorm_moving_meanIdentity_6:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_7IdentityRestoreV2:tensors:7"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_7AssignVariableOp3assignvariableop_7_b1_cf2_batchnorm_moving_varianceIdentity_7:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_8IdentityRestoreV2:tensors:8"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_8AssignVariableOp'assignvariableop_8_b1_cf2_conv2d_kernelIdentity_8:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_9IdentityRestoreV2:tensors:9"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_9AssignVariableOp'assignvariableop_9_t1_cf_batchnorm_betaIdentity_9:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_10IdentityRestoreV2:tensors:10"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_10AssignVariableOp/assignvariableop_10_t1_cf_batchnorm_moving_meanIdentity_10:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_11IdentityRestoreV2:tensors:11"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_11AssignVariableOp3assignvariableop_11_t1_cf_batchnorm_moving_varianceIdentity_11:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_12IdentityRestoreV2:tensors:12"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_12AssignVariableOp'assignvariableop_12_t1_cf_conv2d_kernelIdentity_12:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_13IdentityRestoreV2:tensors:13"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_13AssignVariableOp)assignvariableop_13_b2_cf1_batchnorm_betaIdentity_13:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_14IdentityRestoreV2:tensors:14"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_14AssignVariableOp0assignvariableop_14_b2_cf1_batchnorm_moving_meanIdentity_14:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_15IdentityRestoreV2:tensors:15"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_15AssignVariableOp4assignvariableop_15_b2_cf1_batchnorm_moving_varianceIdentity_15:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_16IdentityRestoreV2:tensors:16"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_16AssignVariableOp(assignvariableop_16_b2_cf1_conv2d_kernelIdentity_16:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_17IdentityRestoreV2:tensors:17"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_17AssignVariableOp)assignvariableop_17_b2_cf2_batchnorm_betaIdentity_17:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_18IdentityRestoreV2:tensors:18"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_18AssignVariableOp0assignvariableop_18_b2_cf2_batchnorm_moving_meanIdentity_18:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_19IdentityRestoreV2:tensors:19"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_19AssignVariableOp4assignvariableop_19_b2_cf2_batchnorm_moving_varianceIdentity_19:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_20IdentityRestoreV2:tensors:20"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_20AssignVariableOp(assignvariableop_20_b2_cf2_conv2d_kernelIdentity_20:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_21IdentityRestoreV2:tensors:21"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_21AssignVariableOp(assignvariableop_21_t2_cf_batchnorm_betaIdentity_21:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_22IdentityRestoreV2:tensors:22"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_22AssignVariableOp/assignvariableop_22_t2_cf_batchnorm_moving_meanIdentity_22:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_23IdentityRestoreV2:tensors:23"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_23AssignVariableOp3assignvariableop_23_t2_cf_batchnorm_moving_varianceIdentity_23:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_24IdentityRestoreV2:tensors:24"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_24AssignVariableOp'assignvariableop_24_t2_cf_conv2d_kernelIdentity_24:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_25IdentityRestoreV2:tensors:25"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_25AssignVariableOp)assignvariableop_25_b3_cf1_batchnorm_betaIdentity_25:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_26IdentityRestoreV2:tensors:26"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_26AssignVariableOp0assignvariableop_26_b3_cf1_batchnorm_moving_meanIdentity_26:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_27IdentityRestoreV2:tensors:27"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_27AssignVariableOp4assignvariableop_27_b3_cf1_batchnorm_moving_varianceIdentity_27:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_28IdentityRestoreV2:tensors:28"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_28AssignVariableOp(assignvariableop_28_b3_cf1_conv2d_kernelIdentity_28:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_29IdentityRestoreV2:tensors:29"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_29AssignVariableOp)assignvariableop_29_b3_cf2_batchnorm_betaIdentity_29:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_30IdentityRestoreV2:tensors:30"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_30AssignVariableOp0assignvariableop_30_b3_cf2_batchnorm_moving_meanIdentity_30:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_31IdentityRestoreV2:tensors:31"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_31AssignVariableOp4assignvariableop_31_b3_cf2_batchnorm_moving_varianceIdentity_31:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_32IdentityRestoreV2:tensors:32"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_32AssignVariableOp(assignvariableop_32_b3_cf2_conv2d_kernelIdentity_32:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_33IdentityRestoreV2:tensors:33"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_33AssignVariableOp(assignvariableop_33_t3_cf_batchnorm_betaIdentity_33:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_34IdentityRestoreV2:tensors:34"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_34AssignVariableOp/assignvariableop_34_t3_cf_batchnorm_moving_meanIdentity_34:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_35IdentityRestoreV2:tensors:35"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_35AssignVariableOp3assignvariableop_35_t3_cf_batchnorm_moving_varianceIdentity_35:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_36IdentityRestoreV2:tensors:36"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_36AssignVariableOp'assignvariableop_36_t3_cf_conv2d_kernelIdentity_36:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_37IdentityRestoreV2:tensors:37"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_37AssignVariableOp)assignvariableop_37_b4_cf1_batchnorm_betaIdentity_37:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_38IdentityRestoreV2:tensors:38"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_38AssignVariableOp0assignvariableop_38_b4_cf1_batchnorm_moving_meanIdentity_38:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_39IdentityRestoreV2:tensors:39"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_39AssignVariableOp4assignvariableop_39_b4_cf1_batchnorm_moving_varianceIdentity_39:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_40IdentityRestoreV2:tensors:40"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_40AssignVariableOp(assignvariableop_40_b4_cf1_conv2d_kernelIdentity_40:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_41IdentityRestoreV2:tensors:41"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_41AssignVariableOp,assignvariableop_41_batch_normalization_betaIdentity_41:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_42IdentityRestoreV2:tensors:42"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_42AssignVariableOp3assignvariableop_42_batch_normalization_moving_meanIdentity_42:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_43IdentityRestoreV2:tensors:43"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_43AssignVariableOp7assignvariableop_43_batch_normalization_moving_varianceIdentity_43:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_44IdentityRestoreV2:tensors:44"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_44AssignVariableOp assignvariableop_44_fc_d1_kernelIdentity_44:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_45IdentityRestoreV2:tensors:45"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_45AssignVariableOp%assignvariableop_45_batchnorm_d1_betaIdentity_45:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_46IdentityRestoreV2:tensors:46"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_46AssignVariableOp,assignvariableop_46_batchnorm_d1_moving_meanIdentity_46:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_47IdentityRestoreV2:tensors:47"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_47AssignVariableOp0assignvariableop_47_batchnorm_d1_moving_varianceIdentity_47:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_48IdentityRestoreV2:tensors:48"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_48AssignVariableOp!assignvariableop_48_logits_kernelIdentity_48:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_49IdentityRestoreV2:tensors:49"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_49AssignVariableOpassignvariableop_49_logits_biasIdentity_49:output:0"/device:CPU:0*
_output_shapes
 *
dtype01
NoOpNoOp"/device:CPU:0*
_output_shapes
 �	
Identity_50Identityfile_prefix^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_10^AssignVariableOp_11^AssignVariableOp_12^AssignVariableOp_13^AssignVariableOp_14^AssignVariableOp_15^AssignVariableOp_16^AssignVariableOp_17^AssignVariableOp_18^AssignVariableOp_19^AssignVariableOp_2^AssignVariableOp_20^AssignVariableOp_21^AssignVariableOp_22^AssignVariableOp_23^AssignVariableOp_24^AssignVariableOp_25^AssignVariableOp_26^AssignVariableOp_27^AssignVariableOp_28^AssignVariableOp_29^AssignVariableOp_3^AssignVariableOp_30^AssignVariableOp_31^AssignVariableOp_32^AssignVariableOp_33^AssignVariableOp_34^AssignVariableOp_35^AssignVariableOp_36^AssignVariableOp_37^AssignVariableOp_38^AssignVariableOp_39^AssignVariableOp_4^AssignVariableOp_40^AssignVariableOp_41^AssignVariableOp_42^AssignVariableOp_43^AssignVariableOp_44^AssignVariableOp_45^AssignVariableOp_46^AssignVariableOp_47^AssignVariableOp_48^AssignVariableOp_49^AssignVariableOp_5^AssignVariableOp_6^AssignVariableOp_7^AssignVariableOp_8^AssignVariableOp_9^NoOp"/device:CPU:0*
T0*
_output_shapes
: W
Identity_51IdentityIdentity_50:output:0^NoOp_1*
T0*
_output_shapes
: �	
NoOp_1NoOp^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_10^AssignVariableOp_11^AssignVariableOp_12^AssignVariableOp_13^AssignVariableOp_14^AssignVariableOp_15^AssignVariableOp_16^AssignVariableOp_17^AssignVariableOp_18^AssignVariableOp_19^AssignVariableOp_2^AssignVariableOp_20^AssignVariableOp_21^AssignVariableOp_22^AssignVariableOp_23^AssignVariableOp_24^AssignVariableOp_25^AssignVariableOp_26^AssignVariableOp_27^AssignVariableOp_28^AssignVariableOp_29^AssignVariableOp_3^AssignVariableOp_30^AssignVariableOp_31^AssignVariableOp_32^AssignVariableOp_33^AssignVariableOp_34^AssignVariableOp_35^AssignVariableOp_36^AssignVariableOp_37^AssignVariableOp_38^AssignVariableOp_39^AssignVariableOp_4^AssignVariableOp_40^AssignVariableOp_41^AssignVariableOp_42^AssignVariableOp_43^AssignVariableOp_44^AssignVariableOp_45^AssignVariableOp_46^AssignVariableOp_47^AssignVariableOp_48^AssignVariableOp_49^AssignVariableOp_5^AssignVariableOp_6^AssignVariableOp_7^AssignVariableOp_8^AssignVariableOp_9*"
_acd_function_control_output(*
_output_shapes
 "#
identity_51Identity_51:output:0*y
_input_shapesh
f: : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : : 2$
AssignVariableOpAssignVariableOp2(
AssignVariableOp_1AssignVariableOp_12*
AssignVariableOp_10AssignVariableOp_102*
AssignVariableOp_11AssignVariableOp_112*
AssignVariableOp_12AssignVariableOp_122*
AssignVariableOp_13AssignVariableOp_132*
AssignVariableOp_14AssignVariableOp_142*
AssignVariableOp_15AssignVariableOp_152*
AssignVariableOp_16AssignVariableOp_162*
AssignVariableOp_17AssignVariableOp_172*
AssignVariableOp_18AssignVariableOp_182*
AssignVariableOp_19AssignVariableOp_192(
AssignVariableOp_2AssignVariableOp_22*
AssignVariableOp_20AssignVariableOp_202*
AssignVariableOp_21AssignVariableOp_212*
AssignVariableOp_22AssignVariableOp_222*
AssignVariableOp_23AssignVariableOp_232*
AssignVariableOp_24AssignVariableOp_242*
AssignVariableOp_25AssignVariableOp_252*
AssignVariableOp_26AssignVariableOp_262*
AssignVariableOp_27AssignVariableOp_272*
AssignVariableOp_28AssignVariableOp_282*
AssignVariableOp_29AssignVariableOp_292(
AssignVariableOp_3AssignVariableOp_32*
AssignVariableOp_30AssignVariableOp_302*
AssignVariableOp_31AssignVariableOp_312*
AssignVariableOp_32AssignVariableOp_322*
AssignVariableOp_33AssignVariableOp_332*
AssignVariableOp_34AssignVariableOp_342*
AssignVariableOp_35AssignVariableOp_352*
AssignVariableOp_36AssignVariableOp_362*
AssignVariableOp_37AssignVariableOp_372*
AssignVariableOp_38AssignVariableOp_382*
AssignVariableOp_39AssignVariableOp_392(
AssignVariableOp_4AssignVariableOp_42*
AssignVariableOp_40AssignVariableOp_402*
AssignVariableOp_41AssignVariableOp_412*
AssignVariableOp_42AssignVariableOp_422*
AssignVariableOp_43AssignVariableOp_432*
AssignVariableOp_44AssignVariableOp_442*
AssignVariableOp_45AssignVariableOp_452*
AssignVariableOp_46AssignVariableOp_462*
AssignVariableOp_47AssignVariableOp_472*
AssignVariableOp_48AssignVariableOp_482*
AssignVariableOp_49AssignVariableOp_492(
AssignVariableOp_5AssignVariableOp_52(
AssignVariableOp_6AssignVariableOp_62(
AssignVariableOp_7AssignVariableOp_72(
AssignVariableOp_8AssignVariableOp_82(
AssignVariableOp_9AssignVariableOp_9:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix
�
F
*__inference_B3_CF2_ReLu_layer_call_fn_7619

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B3_CF2_ReLu_layer_call_and_return_conditional_losses_3148h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
+__inference_BatchNorm-D1_layer_call_fn_8232

inputs
unknown:
	unknown_0:
	unknown_1:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_BatchNorm-D1_layer_call_and_return_conditional_losses_2657o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*,
_input_shapes
:���������: : : 22
StatefulPartitionedCallStatefulPartitionedCall:O K
'
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_6313

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�	
�
/__inference_B3_CF2_BatchNorm_layer_call_fn_7507

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+���������������������������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_2384�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_6670

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_6467

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
M__inference_batch_normalization_layer_call_and_return_conditional_losses_8175

inputs	
scale%
readvariableop_resource:,6
(fusedbatchnormv3_readvariableop_resource:,8
*fusedbatchnormv3_readvariableop_1_resource:,
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:,*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:,*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:,*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������,:,:,:,:,:*
epsilon%��'7*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������,�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������,:,: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������,
 
_user_specified_nameinputs: 

_output_shapes
:,
�

g
H__inference_B2_CF2_Dropout_layer_call_and_return_conditional_losses_7117

inputs
identity�R
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?l
dropout/MulMulinputsdropout/Const:output:0*
T0*/
_output_shapes
:���������C
dropout/ShapeShapeinputs*
T0*
_output_shapes
:�
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*/
_output_shapes
:���������*
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������w
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������q
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*/
_output_shapes
:���������a
IdentityIdentitydropout/Mul_1:z:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
/__inference_B1_CF2_BatchNorm_layer_call_fn_6437

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_2791w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������-C`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������-C:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
?__inference_FC-D1_layer_call_and_return_conditional_losses_3344

inputs0
matmul_readvariableop_resource:,
identity��MatMul/ReadVariableOpt
MatMul/ReadVariableOpReadVariableOpmatmul_readvariableop_resource*
_output_shapes

:,*
dtype0i
MatMulMatMulinputsMatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������_
IdentityIdentityMatMul:product:0^NoOp*
T0*'
_output_shapes
:���������^
NoOpNoOp^MatMul/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*(
_input_shapes
:���������,: 2.
MatMul/ReadVariableOpMatMul/ReadVariableOp:O K
'
_output_shapes
:���������,
 
_user_specified_nameinputs
�
�
,__inference_B3_CF2_Conv2D_layer_call_fn_7631

inputs!
unknown:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B3_CF2_Conv2D_layer_call_and_return_conditional_losses_3157w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������: 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
B
&__inference_T3_Pool_layer_call_fn_7861

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *J
fERC
A__inference_T3_Pool_layer_call_and_return_conditional_losses_3235h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������("
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������	(:W S
/
_output_shapes
:���������	(
 
_user_specified_nameinputs
�
�
/__inference_B3_CF2_BatchNorm_layer_call_fn_7546

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_3819w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs: 

_output_shapes
:
�
_
C__inference_rescaling_layer_call_and_return_conditional_losses_2711

inputs
identityK
Cast/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<M
Cast_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *  �?]
mulMulinputsCast/x:output:0*
T0*/
_output_shapes
:���������-Cb
addAddV2mul:z:0Cast_1/x:output:0*
T0*/
_output_shapes
:���������-CW
IdentityIdentityadd:z:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
]
A__inference_T3_Pool_layer_call_and_return_conditional_losses_7866

inputs
identity�
AvgPoolAvgPoolinputs*
T0*J
_output_shapes8
6:4������������������������������������*
ksize
*
paddingVALID*
strides
{
IdentityIdentityAvgPool:output:0*
T0*J
_output_shapes8
6:4������������������������������������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*I
_input_shapes8
6:4������������������������������������:r n
J
_output_shapes8
6:4������������������������������������
 
_user_specified_nameinputs
�	
�
/__inference_B4_CF1_BatchNorm_layer_call_fn_7897

inputs
unknown
	unknown_0:(
	unknown_1:(
	unknown_2:(
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+���������������������������(*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_2550�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������(`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������(:(: : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+���������������������������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�
�
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_3646

inputs	
scale%
readvariableop_resource:(6
(fusedbatchnormv3_readvariableop_resource:(8
*fusedbatchnormv3_readvariableop_1_resource:(
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������(:(:(:(:(:*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������(�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������(:(: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�	
�
/__inference_B2_CF1_BatchNorm_layer_call_fn_6801

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+���������������������������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_2154�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
a
E__inference_B3_CF1_ReLu_layer_call_and_return_conditional_losses_7453

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:��������� b
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:��������� "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:��������� :W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
�

f
G__inference_T1_CF_Dropout_layer_call_and_return_conditional_losses_6755

inputs
identity�R
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?l
dropout/MulMulinputsdropout/Const:output:0*
T0*/
_output_shapes
:���������-CC
dropout/ShapeShapeinputs*
T0*
_output_shapes
:�
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*/
_output_shapes
:���������-C*
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������-Cw
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������-Cq
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*/
_output_shapes
:���������-Ca
IdentityIdentitydropout/Mul_1:z:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
�
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_7032

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������:::::*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+����������������������������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_2550

inputs	
scale%
readvariableop_resource:(6
(fusedbatchnormv3_readvariableop_resource:(8
*fusedbatchnormv3_readvariableop_1_resource:(
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������(:(:(:(:(:*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������(�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������(:(: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�
�
F__inference_T1_CF_Conv2D_layer_call_and_return_conditional_losses_6728

inputs8
conv2d_readvariableop_resource:
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingVALID*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:���������-C^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������-C: 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
�
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_7957

inputs	
scale%
readvariableop_resource:(6
(fusedbatchnormv3_readvariableop_resource:(8
*fusedbatchnormv3_readvariableop_1_resource:(
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������(:(:(:(:(:*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������(�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������(:(: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�
E
)__inference_T1_CF_ReLu_layer_call_fn_6709

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *M
fHRF
D__inference_T1_CF_ReLu_layer_call_and_return_conditional_losses_2867h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������-C"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������-C:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs
�
�
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_3023

inputs	
scale%
readvariableop_resource: 6
(fusedbatchnormv3_readvariableop_resource: 8
*fusedbatchnormv3_readvariableop_1_resource: 
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:��������� : : : : :*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:��������� �
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':��������� : : : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
�
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_2911

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:����������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_7974

inputs	
scale%
readvariableop_resource:(6
(fusedbatchnormv3_readvariableop_resource:(8
*fusedbatchnormv3_readvariableop_1_resource:(
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������(:(:(:(:(:*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������(�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������(:(: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs: 

_output_shapes
:(
��
�5
__inference__wrapped_model_1905
input_1J
0densenet_pre_conv_conv2d_readvariableop_resource:#
densenet_b1_cf1_batchnorm_scale?
1densenet_b1_cf1_batchnorm_readvariableop_resource:P
Bdensenet_b1_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource:R
Ddensenet_b1_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource:O
5densenet_b1_cf1_conv2d_conv2d_readvariableop_resource:#
densenet_b1_cf2_batchnorm_scale?
1densenet_b1_cf2_batchnorm_readvariableop_resource:P
Bdensenet_b1_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource:R
Ddensenet_b1_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource:O
5densenet_b1_cf2_conv2d_conv2d_readvariableop_resource:"
densenet_t1_cf_batchnorm_scale>
0densenet_t1_cf_batchnorm_readvariableop_resource:O
Adensenet_t1_cf_batchnorm_fusedbatchnormv3_readvariableop_resource:Q
Cdensenet_t1_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource:N
4densenet_t1_cf_conv2d_conv2d_readvariableop_resource:#
densenet_b2_cf1_batchnorm_scale?
1densenet_b2_cf1_batchnorm_readvariableop_resource:P
Bdensenet_b2_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource:R
Ddensenet_b2_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource:O
5densenet_b2_cf1_conv2d_conv2d_readvariableop_resource:#
densenet_b2_cf2_batchnorm_scale?
1densenet_b2_cf2_batchnorm_readvariableop_resource:P
Bdensenet_b2_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource:R
Ddensenet_b2_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource:O
5densenet_b2_cf2_conv2d_conv2d_readvariableop_resource:"
densenet_t2_cf_batchnorm_scale>
0densenet_t2_cf_batchnorm_readvariableop_resource: O
Adensenet_t2_cf_batchnorm_fusedbatchnormv3_readvariableop_resource: Q
Cdensenet_t2_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource: N
4densenet_t2_cf_conv2d_conv2d_readvariableop_resource:  #
densenet_b3_cf1_batchnorm_scale?
1densenet_b3_cf1_batchnorm_readvariableop_resource: P
Bdensenet_b3_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource: R
Ddensenet_b3_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource: O
5densenet_b3_cf1_conv2d_conv2d_readvariableop_resource: #
densenet_b3_cf2_batchnorm_scale?
1densenet_b3_cf2_batchnorm_readvariableop_resource:P
Bdensenet_b3_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource:R
Ddensenet_b3_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource:O
5densenet_b3_cf2_conv2d_conv2d_readvariableop_resource:"
densenet_t3_cf_batchnorm_scale>
0densenet_t3_cf_batchnorm_readvariableop_resource:(O
Adensenet_t3_cf_batchnorm_fusedbatchnormv3_readvariableop_resource:(Q
Cdensenet_t3_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource:(N
4densenet_t3_cf_conv2d_conv2d_readvariableop_resource:((#
densenet_b4_cf1_batchnorm_scale?
1densenet_b4_cf1_batchnorm_readvariableop_resource:(P
Bdensenet_b4_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource:(R
Ddensenet_b4_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource:(O
5densenet_b4_cf1_conv2d_conv2d_readvariableop_resource:(&
"densenet_batch_normalization_scaleB
4densenet_batch_normalization_readvariableop_resource:,S
Edensenet_batch_normalization_fusedbatchnormv3_readvariableop_resource:,U
Gdensenet_batch_normalization_fusedbatchnormv3_readvariableop_1_resource:,?
-densenet_fc_d1_matmul_readvariableop_resource:,E
7densenet_batchnorm_d1_batchnorm_readvariableop_resource:G
9densenet_batchnorm_d1_batchnorm_readvariableop_1_resource:G
9densenet_batchnorm_d1_batchnorm_readvariableop_2_resource:@
.densenet_logits_matmul_readvariableop_resource:=
/densenet_logits_biasadd_readvariableop_resource:
identity��9DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B1_CF1_BatchNorm/ReadVariableOp�,DenseNet/B1_CF1_Conv2D/Conv2D/ReadVariableOp�9DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B1_CF2_BatchNorm/ReadVariableOp�,DenseNet/B1_CF2_Conv2D/Conv2D/ReadVariableOp�9DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B2_CF1_BatchNorm/ReadVariableOp�,DenseNet/B2_CF1_Conv2D/Conv2D/ReadVariableOp�9DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B2_CF2_BatchNorm/ReadVariableOp�,DenseNet/B2_CF2_Conv2D/Conv2D/ReadVariableOp�9DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B3_CF1_BatchNorm/ReadVariableOp�,DenseNet/B3_CF1_Conv2D/Conv2D/ReadVariableOp�9DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B3_CF2_BatchNorm/ReadVariableOp�,DenseNet/B3_CF2_Conv2D/Conv2D/ReadVariableOp�9DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp�;DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�(DenseNet/B4_CF1_BatchNorm/ReadVariableOp�,DenseNet/B4_CF1_Conv2D/Conv2D/ReadVariableOp�.DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp�0DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_1�0DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_2�$DenseNet/FC-D1/MatMul/ReadVariableOp�&DenseNet/Logits/BiasAdd/ReadVariableOp�%DenseNet/Logits/MatMul/ReadVariableOp�'DenseNet/Pre_Conv/Conv2D/ReadVariableOp�8DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp�:DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�'DenseNet/T1_CF_BatchNorm/ReadVariableOp�+DenseNet/T1_CF_Conv2D/Conv2D/ReadVariableOp�8DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp�:DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�'DenseNet/T2_CF_BatchNorm/ReadVariableOp�+DenseNet/T2_CF_Conv2D/Conv2D/ReadVariableOp�8DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp�:DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1�'DenseNet/T3_CF_BatchNorm/ReadVariableOp�+DenseNet/T3_CF_Conv2D/Conv2D/ReadVariableOp�<DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp�>DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp_1�+DenseNet/batch_normalization/ReadVariableOph
&DenseNet/tf.expand_dims/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B :�
"DenseNet/tf.expand_dims/ExpandDims
ExpandDimsinput_1/DenseNet/tf.expand_dims/ExpandDims/dim:output:0*
T0*/
_output_shapes
:���������-C^
DenseNet/rescaling/Cast/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<`
DenseNet/rescaling/Cast_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *  �?�
DenseNet/rescaling/mulMul+DenseNet/tf.expand_dims/ExpandDims:output:0"DenseNet/rescaling/Cast/x:output:0*
T0*/
_output_shapes
:���������-C�
DenseNet/rescaling/addAddV2DenseNet/rescaling/mul:z:0$DenseNet/rescaling/Cast_1/x:output:0*
T0*/
_output_shapes
:���������-C�
'DenseNet/Pre_Conv/Conv2D/ReadVariableOpReadVariableOp0densenet_pre_conv_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/Pre_Conv/Conv2DConv2DDenseNet/rescaling/add:z:0/DenseNet/Pre_Conv/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
�
(DenseNet/B1_CF1_BatchNorm/ReadVariableOpReadVariableOp1densenet_b1_cf1_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
9DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b1_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
;DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b1_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
*DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3FusedBatchNormV3!DenseNet/Pre_Conv/Conv2D:output:0densenet_b1_cf1_batchnorm_scale0DenseNet/B1_CF1_BatchNorm/ReadVariableOp:value:0ADenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( �
DenseNet/B1_CF1_ReLu/ReluRelu.DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������-C�
,DenseNet/B1_CF1_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b1_cf1_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/B1_CF1_Conv2D/Conv2DConv2D'DenseNet/B1_CF1_ReLu/Relu:activations:04DenseNet/B1_CF1_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
�
 DenseNet/B1_CF1_Dropout/IdentityIdentity&DenseNet/B1_CF1_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������-C�
(DenseNet/B1_CF2_BatchNorm/ReadVariableOpReadVariableOp1densenet_b1_cf2_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
9DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b1_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
;DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b1_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
*DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3FusedBatchNormV3)DenseNet/B1_CF1_Dropout/Identity:output:0densenet_b1_cf2_batchnorm_scale0DenseNet/B1_CF2_BatchNorm/ReadVariableOp:value:0ADenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( �
DenseNet/B1_CF2_ReLu/ReluRelu.DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������-C�
,DenseNet/B1_CF2_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b1_cf2_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/B1_CF2_Conv2D/Conv2DConv2D'DenseNet/B1_CF2_ReLu/Relu:activations:04DenseNet/B1_CF2_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingSAME*
strides
�
 DenseNet/B1_CF2_Dropout/IdentityIdentity&DenseNet/B1_CF2_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������-C`
DenseNet/B1_Concat/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
DenseNet/B1_Concat/concatConcatV2!DenseNet/Pre_Conv/Conv2D:output:0)DenseNet/B1_CF1_Dropout/Identity:output:0)DenseNet/B1_CF2_Dropout/Identity:output:0'DenseNet/B1_Concat/concat/axis:output:0*
N*
T0*/
_output_shapes
:���������-C�
'DenseNet/T1_CF_BatchNorm/ReadVariableOpReadVariableOp0densenet_t1_cf_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
8DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpAdensenet_t1_cf_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
:DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpCdensenet_t1_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
)DenseNet/T1_CF_BatchNorm/FusedBatchNormV3FusedBatchNormV3"DenseNet/B1_Concat/concat:output:0densenet_t1_cf_batchnorm_scale/DenseNet/T1_CF_BatchNorm/ReadVariableOp:value:0@DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0BDenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( �
DenseNet/T1_CF_ReLu/ReluRelu-DenseNet/T1_CF_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������-C�
+DenseNet/T1_CF_Conv2D/Conv2D/ReadVariableOpReadVariableOp4densenet_t1_cf_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/T1_CF_Conv2D/Conv2DConv2D&DenseNet/T1_CF_ReLu/Relu:activations:03DenseNet/T1_CF_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������-C*
paddingVALID*
strides
�
DenseNet/T1_CF_Dropout/IdentityIdentity%DenseNet/T1_CF_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������-C�
&DenseNet/tf.compat.v1.pad/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
DenseNet/tf.compat.v1.pad/PadPad(DenseNet/T1_CF_Dropout/Identity:output:0/DenseNet/tf.compat.v1.pad/Pad/paddings:output:0*
T0*/
_output_shapes
:���������-E�
DenseNet/T1_Pool/AvgPoolAvgPool&DenseNet/tf.compat.v1.pad/Pad:output:0*
T0*/
_output_shapes
:���������*
ksize
*
paddingVALID*
strides
�
(DenseNet/B2_CF1_BatchNorm/ReadVariableOpReadVariableOp1densenet_b2_cf1_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
9DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b2_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
;DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b2_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
*DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3FusedBatchNormV3!DenseNet/T1_Pool/AvgPool:output:0densenet_b2_cf1_batchnorm_scale0DenseNet/B2_CF1_BatchNorm/ReadVariableOp:value:0ADenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( �
DenseNet/B2_CF1_ReLu/ReluRelu.DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:����������
,DenseNet/B2_CF1_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b2_cf1_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/B2_CF1_Conv2D/Conv2DConv2D'DenseNet/B2_CF1_ReLu/Relu:activations:04DenseNet/B2_CF1_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
�
 DenseNet/B2_CF1_Dropout/IdentityIdentity&DenseNet/B2_CF1_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:����������
(DenseNet/B2_CF2_BatchNorm/ReadVariableOpReadVariableOp1densenet_b2_cf2_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
9DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b2_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
;DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b2_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
*DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3FusedBatchNormV3)DenseNet/B2_CF1_Dropout/Identity:output:0densenet_b2_cf2_batchnorm_scale0DenseNet/B2_CF2_BatchNorm/ReadVariableOp:value:0ADenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( �
DenseNet/B2_CF2_ReLu/ReluRelu.DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:����������
,DenseNet/B2_CF2_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b2_cf2_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/B2_CF2_Conv2D/Conv2DConv2D'DenseNet/B2_CF2_ReLu/Relu:activations:04DenseNet/B2_CF2_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
�
 DenseNet/B2_CF2_Dropout/IdentityIdentity&DenseNet/B2_CF2_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������`
DenseNet/B2_Concat/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
DenseNet/B2_Concat/concatConcatV2!DenseNet/T1_Pool/AvgPool:output:0)DenseNet/B2_CF1_Dropout/Identity:output:0)DenseNet/B2_CF2_Dropout/Identity:output:0'DenseNet/B2_Concat/concat/axis:output:0*
N*
T0*/
_output_shapes
:��������� �
'DenseNet/T2_CF_BatchNorm/ReadVariableOpReadVariableOp0densenet_t2_cf_batchnorm_readvariableop_resource*
_output_shapes
: *
dtype0�
8DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpAdensenet_t2_cf_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
:DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpCdensenet_t2_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
)DenseNet/T2_CF_BatchNorm/FusedBatchNormV3FusedBatchNormV3"DenseNet/B2_Concat/concat:output:0densenet_t2_cf_batchnorm_scale/DenseNet/T2_CF_BatchNorm/ReadVariableOp:value:0@DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0BDenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:��������� : : : : :*
epsilon%o�:*
is_training( �
DenseNet/T2_CF_ReLu/ReluRelu-DenseNet/T2_CF_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:��������� �
+DenseNet/T2_CF_Conv2D/Conv2D/ReadVariableOpReadVariableOp4densenet_t2_cf_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:  *
dtype0�
DenseNet/T2_CF_Conv2D/Conv2DConv2D&DenseNet/T2_CF_ReLu/Relu:activations:03DenseNet/T2_CF_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:��������� *
paddingVALID*
strides
�
DenseNet/T2_CF_Dropout/IdentityIdentity%DenseNet/T2_CF_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:��������� �
(DenseNet/tf.compat.v1.pad_1/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
DenseNet/tf.compat.v1.pad_1/PadPad(DenseNet/T2_CF_Dropout/Identity:output:01DenseNet/tf.compat.v1.pad_1/Pad/paddings:output:0*
T0*/
_output_shapes
:��������� �
DenseNet/T2_Pool/AvgPoolAvgPool(DenseNet/tf.compat.v1.pad_1/Pad:output:0*
T0*/
_output_shapes
:��������� *
ksize
*
paddingVALID*
strides
�
(DenseNet/B3_CF1_BatchNorm/ReadVariableOpReadVariableOp1densenet_b3_cf1_batchnorm_readvariableop_resource*
_output_shapes
: *
dtype0�
9DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b3_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
;DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b3_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
*DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3FusedBatchNormV3!DenseNet/T2_Pool/AvgPool:output:0densenet_b3_cf1_batchnorm_scale0DenseNet/B3_CF1_BatchNorm/ReadVariableOp:value:0ADenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:��������� : : : : :*
epsilon%o�:*
is_training( �
DenseNet/B3_CF1_ReLu/ReluRelu.DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:��������� �
,DenseNet/B3_CF1_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b3_cf1_conv2d_conv2d_readvariableop_resource*&
_output_shapes
: *
dtype0�
DenseNet/B3_CF1_Conv2D/Conv2DConv2D'DenseNet/B3_CF1_ReLu/Relu:activations:04DenseNet/B3_CF1_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
�
 DenseNet/B3_CF1_Dropout/IdentityIdentity&DenseNet/B3_CF1_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:����������
(DenseNet/B3_CF2_BatchNorm/ReadVariableOpReadVariableOp1densenet_b3_cf2_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0�
9DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b3_cf2_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
;DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b3_cf2_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
*DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3FusedBatchNormV3)DenseNet/B3_CF1_Dropout/Identity:output:0densenet_b3_cf2_batchnorm_scale0DenseNet/B3_CF2_BatchNorm/ReadVariableOp:value:0ADenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( �
DenseNet/B3_CF2_ReLu/ReluRelu.DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:����������
,DenseNet/B3_CF2_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b3_cf2_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
DenseNet/B3_CF2_Conv2D/Conv2DConv2D'DenseNet/B3_CF2_ReLu/Relu:activations:04DenseNet/B3_CF2_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
�
 DenseNet/B3_CF2_Dropout/IdentityIdentity&DenseNet/B3_CF2_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������`
DenseNet/B3_Concat/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
DenseNet/B3_Concat/concatConcatV2!DenseNet/T2_Pool/AvgPool:output:0)DenseNet/B3_CF1_Dropout/Identity:output:0)DenseNet/B3_CF2_Dropout/Identity:output:0'DenseNet/B3_Concat/concat/axis:output:0*
N*
T0*/
_output_shapes
:���������(�
'DenseNet/T3_CF_BatchNorm/ReadVariableOpReadVariableOp0densenet_t3_cf_batchnorm_readvariableop_resource*
_output_shapes
:(*
dtype0�
8DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpAdensenet_t3_cf_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
:DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpCdensenet_t3_cf_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
)DenseNet/T3_CF_BatchNorm/FusedBatchNormV3FusedBatchNormV3"DenseNet/B3_Concat/concat:output:0densenet_t3_cf_batchnorm_scale/DenseNet/T3_CF_BatchNorm/ReadVariableOp:value:0@DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0BDenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������(:(:(:(:(:*
epsilon%o�:*
is_training( �
DenseNet/T3_CF_ReLu/ReluRelu-DenseNet/T3_CF_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������(�
+DenseNet/T3_CF_Conv2D/Conv2D/ReadVariableOpReadVariableOp4densenet_t3_cf_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:((*
dtype0�
DenseNet/T3_CF_Conv2D/Conv2DConv2D&DenseNet/T3_CF_ReLu/Relu:activations:03DenseNet/T3_CF_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������(*
paddingVALID*
strides
�
DenseNet/T3_CF_Dropout/IdentityIdentity%DenseNet/T3_CF_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������(�
(DenseNet/tf.compat.v1.pad_2/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
DenseNet/tf.compat.v1.pad_2/PadPad(DenseNet/T3_CF_Dropout/Identity:output:01DenseNet/tf.compat.v1.pad_2/Pad/paddings:output:0*
T0*/
_output_shapes
:���������	(�
DenseNet/T3_Pool/AvgPoolAvgPool(DenseNet/tf.compat.v1.pad_2/Pad:output:0*
T0*/
_output_shapes
:���������(*
ksize
*
paddingVALID*
strides
�
(DenseNet/B4_CF1_BatchNorm/ReadVariableOpReadVariableOp1densenet_b4_cf1_batchnorm_readvariableop_resource*
_output_shapes
:(*
dtype0�
9DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOpReadVariableOpBdensenet_b4_cf1_batchnorm_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
;DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpDdensenet_b4_cf1_batchnorm_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
*DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3FusedBatchNormV3!DenseNet/T3_Pool/AvgPool:output:0densenet_b4_cf1_batchnorm_scale0DenseNet/B4_CF1_BatchNorm/ReadVariableOp:value:0ADenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp:value:0CDenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������(:(:(:(:(:*
epsilon%o�:*
is_training( �
DenseNet/B4_CF1_ReLu/ReluRelu.DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������(�
,DenseNet/B4_CF1_Conv2D/Conv2D/ReadVariableOpReadVariableOp5densenet_b4_cf1_conv2d_conv2d_readvariableop_resource*&
_output_shapes
:(*
dtype0�
DenseNet/B4_CF1_Conv2D/Conv2DConv2D'DenseNet/B4_CF1_ReLu/Relu:activations:04DenseNet/B4_CF1_Conv2D/Conv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
�
 DenseNet/B4_CF1_Dropout/IdentityIdentity&DenseNet/B4_CF1_Conv2D/Conv2D:output:0*
T0*/
_output_shapes
:���������`
DenseNet/B4_Concat/concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
DenseNet/B4_Concat/concatConcatV2!DenseNet/T3_Pool/AvgPool:output:0)DenseNet/B4_CF1_Dropout/Identity:output:0'DenseNet/B4_Concat/concat/axis:output:0*
N*
T0*/
_output_shapes
:���������,�
+DenseNet/batch_normalization/ReadVariableOpReadVariableOp4densenet_batch_normalization_readvariableop_resource*
_output_shapes
:,*
dtype0�
<DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOpReadVariableOpEdensenet_batch_normalization_fusedbatchnormv3_readvariableop_resource*
_output_shapes
:,*
dtype0�
>DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp_1ReadVariableOpGdensenet_batch_normalization_fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:,*
dtype0�
-DenseNet/batch_normalization/FusedBatchNormV3FusedBatchNormV3"DenseNet/B4_Concat/concat:output:0"densenet_batch_normalization_scale3DenseNet/batch_normalization/ReadVariableOp:value:0DDenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp:value:0FDenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������,:,:,:,:,:*
epsilon%��'7*
is_training( �
DenseNet/ReLu/ReluRelu1DenseNet/batch_normalization/FusedBatchNormV3:y:0*
T0*/
_output_shapes
:���������,�
8DenseNet/global_average_pooling2d/Mean/reduction_indicesConst*
_output_shapes
:*
dtype0*
valueB"      �
&DenseNet/global_average_pooling2d/MeanMean DenseNet/ReLu/Relu:activations:0ADenseNet/global_average_pooling2d/Mean/reduction_indices:output:0*
T0*'
_output_shapes
:���������,�
$DenseNet/FC-D1/MatMul/ReadVariableOpReadVariableOp-densenet_fc_d1_matmul_readvariableop_resource*
_output_shapes

:,*
dtype0�
DenseNet/FC-D1/MatMulMatMul/DenseNet/global_average_pooling2d/Mean:output:0,DenseNet/FC-D1/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:����������
.DenseNet/BatchNorm-D1/batchnorm/ReadVariableOpReadVariableOp7densenet_batchnorm_d1_batchnorm_readvariableop_resource*
_output_shapes
:*
dtype0j
%DenseNet/BatchNorm-D1/batchnorm/add/yConst*
_output_shapes
: *
dtype0*
valueB
 *w�+2�
#DenseNet/BatchNorm-D1/batchnorm/addAddV26DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp:value:0.DenseNet/BatchNorm-D1/batchnorm/add/y:output:0*
T0*
_output_shapes
:|
%DenseNet/BatchNorm-D1/batchnorm/RsqrtRsqrt'DenseNet/BatchNorm-D1/batchnorm/add:z:0*
T0*
_output_shapes
:�
#DenseNet/BatchNorm-D1/batchnorm/mulMulDenseNet/FC-D1/MatMul:product:0)DenseNet/BatchNorm-D1/batchnorm/Rsqrt:y:0*
T0*'
_output_shapes
:����������
0DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_1ReadVariableOp9densenet_batchnorm_d1_batchnorm_readvariableop_1_resource*
_output_shapes
:*
dtype0�
%DenseNet/BatchNorm-D1/batchnorm/mul_1Mul8DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_1:value:0)DenseNet/BatchNorm-D1/batchnorm/Rsqrt:y:0*
T0*
_output_shapes
:�
0DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_2ReadVariableOp9densenet_batchnorm_d1_batchnorm_readvariableop_2_resource*
_output_shapes
:*
dtype0�
#DenseNet/BatchNorm-D1/batchnorm/subSub8DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_2:value:0)DenseNet/BatchNorm-D1/batchnorm/mul_1:z:0*
T0*
_output_shapes
:�
%DenseNet/BatchNorm-D1/batchnorm/add_1AddV2'DenseNet/BatchNorm-D1/batchnorm/mul:z:0'DenseNet/BatchNorm-D1/batchnorm/sub:z:0*
T0*'
_output_shapes
:����������
%DenseNet/Logits/MatMul/ReadVariableOpReadVariableOp.densenet_logits_matmul_readvariableop_resource*
_output_shapes

:*
dtype0�
DenseNet/Logits/MatMulMatMul)DenseNet/BatchNorm-D1/batchnorm/add_1:z:0-DenseNet/Logits/MatMul/ReadVariableOp:value:0*
T0*'
_output_shapes
:����������
&DenseNet/Logits/BiasAdd/ReadVariableOpReadVariableOp/densenet_logits_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0�
DenseNet/Logits/BiasAddBiasAdd DenseNet/Logits/MatMul:product:0.DenseNet/Logits/BiasAdd/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������v
DenseNet/Logits/SigmoidSigmoid DenseNet/Logits/BiasAdd:output:0*
T0*'
_output_shapes
:���������j
IdentityIdentityDenseNet/Logits/Sigmoid:y:0^NoOp*
T0*'
_output_shapes
:����������
NoOpNoOp:^DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B1_CF1_BatchNorm/ReadVariableOp-^DenseNet/B1_CF1_Conv2D/Conv2D/ReadVariableOp:^DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B1_CF2_BatchNorm/ReadVariableOp-^DenseNet/B1_CF2_Conv2D/Conv2D/ReadVariableOp:^DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B2_CF1_BatchNorm/ReadVariableOp-^DenseNet/B2_CF1_Conv2D/Conv2D/ReadVariableOp:^DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B2_CF2_BatchNorm/ReadVariableOp-^DenseNet/B2_CF2_Conv2D/Conv2D/ReadVariableOp:^DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B3_CF1_BatchNorm/ReadVariableOp-^DenseNet/B3_CF1_Conv2D/Conv2D/ReadVariableOp:^DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B3_CF2_BatchNorm/ReadVariableOp-^DenseNet/B3_CF2_Conv2D/Conv2D/ReadVariableOp:^DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp<^DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1)^DenseNet/B4_CF1_BatchNorm/ReadVariableOp-^DenseNet/B4_CF1_Conv2D/Conv2D/ReadVariableOp/^DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp1^DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_11^DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_2%^DenseNet/FC-D1/MatMul/ReadVariableOp'^DenseNet/Logits/BiasAdd/ReadVariableOp&^DenseNet/Logits/MatMul/ReadVariableOp(^DenseNet/Pre_Conv/Conv2D/ReadVariableOp9^DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp;^DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1(^DenseNet/T1_CF_BatchNorm/ReadVariableOp,^DenseNet/T1_CF_Conv2D/Conv2D/ReadVariableOp9^DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp;^DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1(^DenseNet/T2_CF_BatchNorm/ReadVariableOp,^DenseNet/T2_CF_Conv2D/Conv2D/ReadVariableOp9^DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp;^DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1(^DenseNet/T3_CF_BatchNorm/ReadVariableOp,^DenseNet/T3_CF_Conv2D/Conv2D/ReadVariableOp=^DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp?^DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp_1,^DenseNet/batch_normalization/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*�
_input_shapes�
�:���������-C: :: : : : :: : : : :: : : : :: : : : :: : : : : : : : : : : : : : :: : : : :(: : : : :(: : : : :,: : : : : : : : : 2v
9DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B1_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B1_CF1_BatchNorm/ReadVariableOp(DenseNet/B1_CF1_BatchNorm/ReadVariableOp2\
,DenseNet/B1_CF1_Conv2D/Conv2D/ReadVariableOp,DenseNet/B1_CF1_Conv2D/Conv2D/ReadVariableOp2v
9DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B1_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B1_CF2_BatchNorm/ReadVariableOp(DenseNet/B1_CF2_BatchNorm/ReadVariableOp2\
,DenseNet/B1_CF2_Conv2D/Conv2D/ReadVariableOp,DenseNet/B1_CF2_Conv2D/Conv2D/ReadVariableOp2v
9DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B2_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B2_CF1_BatchNorm/ReadVariableOp(DenseNet/B2_CF1_BatchNorm/ReadVariableOp2\
,DenseNet/B2_CF1_Conv2D/Conv2D/ReadVariableOp,DenseNet/B2_CF1_Conv2D/Conv2D/ReadVariableOp2v
9DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B2_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B2_CF2_BatchNorm/ReadVariableOp(DenseNet/B2_CF2_BatchNorm/ReadVariableOp2\
,DenseNet/B2_CF2_Conv2D/Conv2D/ReadVariableOp,DenseNet/B2_CF2_Conv2D/Conv2D/ReadVariableOp2v
9DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B3_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B3_CF1_BatchNorm/ReadVariableOp(DenseNet/B3_CF1_BatchNorm/ReadVariableOp2\
,DenseNet/B3_CF1_Conv2D/Conv2D/ReadVariableOp,DenseNet/B3_CF1_Conv2D/Conv2D/ReadVariableOp2v
9DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B3_CF2_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B3_CF2_BatchNorm/ReadVariableOp(DenseNet/B3_CF2_BatchNorm/ReadVariableOp2\
,DenseNet/B3_CF2_Conv2D/Conv2D/ReadVariableOp,DenseNet/B3_CF2_Conv2D/Conv2D/ReadVariableOp2v
9DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp9DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp2z
;DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_1;DenseNet/B4_CF1_BatchNorm/FusedBatchNormV3/ReadVariableOp_12T
(DenseNet/B4_CF1_BatchNorm/ReadVariableOp(DenseNet/B4_CF1_BatchNorm/ReadVariableOp2\
,DenseNet/B4_CF1_Conv2D/Conv2D/ReadVariableOp,DenseNet/B4_CF1_Conv2D/Conv2D/ReadVariableOp2`
.DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp.DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp2d
0DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_10DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_12d
0DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_20DenseNet/BatchNorm-D1/batchnorm/ReadVariableOp_22L
$DenseNet/FC-D1/MatMul/ReadVariableOp$DenseNet/FC-D1/MatMul/ReadVariableOp2P
&DenseNet/Logits/BiasAdd/ReadVariableOp&DenseNet/Logits/BiasAdd/ReadVariableOp2N
%DenseNet/Logits/MatMul/ReadVariableOp%DenseNet/Logits/MatMul/ReadVariableOp2R
'DenseNet/Pre_Conv/Conv2D/ReadVariableOp'DenseNet/Pre_Conv/Conv2D/ReadVariableOp2t
8DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp8DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2x
:DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:DenseNet/T1_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_12R
'DenseNet/T1_CF_BatchNorm/ReadVariableOp'DenseNet/T1_CF_BatchNorm/ReadVariableOp2Z
+DenseNet/T1_CF_Conv2D/Conv2D/ReadVariableOp+DenseNet/T1_CF_Conv2D/Conv2D/ReadVariableOp2t
8DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp8DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2x
:DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:DenseNet/T2_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_12R
'DenseNet/T2_CF_BatchNorm/ReadVariableOp'DenseNet/T2_CF_BatchNorm/ReadVariableOp2Z
+DenseNet/T2_CF_Conv2D/Conv2D/ReadVariableOp+DenseNet/T2_CF_Conv2D/Conv2D/ReadVariableOp2t
8DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp8DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp2x
:DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_1:DenseNet/T3_CF_BatchNorm/FusedBatchNormV3/ReadVariableOp_12R
'DenseNet/T3_CF_BatchNorm/ReadVariableOp'DenseNet/T3_CF_BatchNorm/ReadVariableOp2Z
+DenseNet/T3_CF_Conv2D/Conv2D/ReadVariableOp+DenseNet/T3_CF_Conv2D/Conv2D/ReadVariableOp2|
<DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp<DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp2�
>DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp_1>DenseNet/batch_normalization/FusedBatchNormV3/ReadVariableOp_12Z
+DenseNet/batch_normalization/ReadVariableOp+DenseNet/batch_normalization/ReadVariableOp:T P
+
_output_shapes
:���������-C
!
_user_specified_name	input_1: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
: :  

_output_shapes
: : %

_output_shapes
:: *

_output_shapes
:(: /

_output_shapes
:(: 4

_output_shapes
:,
�
�
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_3253

inputs	
scale%
readvariableop_resource:(6
(fusedbatchnormv3_readvariableop_resource:(8
*fusedbatchnormv3_readvariableop_1_resource:(
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������(:(:(:(:(:*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������(�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������(:(: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�
f
-__inference_B2_CF1_Dropout_layer_call_fn_6929

inputs
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B2_CF1_Dropout_layer_call_and_return_conditional_losses_4103w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
F__inference_T2_CF_Conv2D_layer_call_and_return_conditional_losses_7276

inputs8
conv2d_readvariableop_resource:  
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
:  *
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:��������� *
paddingVALID*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:��������� ^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:��������� : 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
�
a
E__inference_B4_CF1_ReLu_layer_call_and_return_conditional_losses_3268

inputs
identityN
ReluReluinputs*
T0*/
_output_shapes
:���������(b
IdentityIdentityRelu:activations:0*
T0*/
_output_shapes
:���������("
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������(:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs
�
F
*__inference_B2_CF2_ReLu_layer_call_fn_7071

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B2_CF2_ReLu_layer_call_and_return_conditional_losses_2977h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
M__inference_batch_normalization_layer_call_and_return_conditional_losses_2582

inputs	
scale%
readvariableop_resource:,6
(fusedbatchnormv3_readvariableop_resource:,8
*fusedbatchnormv3_readvariableop_1_resource:,
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:,*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:,*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:,*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������,:,:,:,:,:*
epsilon%��'7*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������,�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������,:,: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������,
 
_user_specified_nameinputs: 

_output_shapes
:,
�
�
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_3899

inputs	
scale%
readvariableop_resource: 6
(fusedbatchnormv3_readvariableop_resource: 8
*fusedbatchnormv3_readvariableop_1_resource: 
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:��������� : : : : :*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:��������� �
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':��������� : : : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
�
G__inference_B3_CF2_Conv2D_layer_call_and_return_conditional_losses_7638

inputs8
conv2d_readvariableop_resource:
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:���������^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������: 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_6330

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������-C�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������-C:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:
��
�
B__inference_DenseNet_layer_call_and_return_conditional_losses_5189
input_1'
pre_conv_5006:
b1_cf1_batchnorm_5009#
b1_cf1_batchnorm_5011:#
b1_cf1_batchnorm_5013:#
b1_cf1_batchnorm_5015:,
b1_cf1_conv2d_5019:
b1_cf2_batchnorm_5023#
b1_cf2_batchnorm_5025:#
b1_cf2_batchnorm_5027:#
b1_cf2_batchnorm_5029:,
b1_cf2_conv2d_5033:
t1_cf_batchnorm_5038"
t1_cf_batchnorm_5040:"
t1_cf_batchnorm_5042:"
t1_cf_batchnorm_5044:+
t1_cf_conv2d_5048:
b2_cf1_batchnorm_5055#
b2_cf1_batchnorm_5057:#
b2_cf1_batchnorm_5059:#
b2_cf1_batchnorm_5061:,
b2_cf1_conv2d_5065:
b2_cf2_batchnorm_5069#
b2_cf2_batchnorm_5071:#
b2_cf2_batchnorm_5073:#
b2_cf2_batchnorm_5075:,
b2_cf2_conv2d_5079:
t2_cf_batchnorm_5084"
t2_cf_batchnorm_5086: "
t2_cf_batchnorm_5088: "
t2_cf_batchnorm_5090: +
t2_cf_conv2d_5094:  
b3_cf1_batchnorm_5101#
b3_cf1_batchnorm_5103: #
b3_cf1_batchnorm_5105: #
b3_cf1_batchnorm_5107: ,
b3_cf1_conv2d_5111: 
b3_cf2_batchnorm_5115#
b3_cf2_batchnorm_5117:#
b3_cf2_batchnorm_5119:#
b3_cf2_batchnorm_5121:,
b3_cf2_conv2d_5125:
t3_cf_batchnorm_5130"
t3_cf_batchnorm_5132:("
t3_cf_batchnorm_5134:("
t3_cf_batchnorm_5136:(+
t3_cf_conv2d_5140:((
b4_cf1_batchnorm_5147#
b4_cf1_batchnorm_5149:(#
b4_cf1_batchnorm_5151:(#
b4_cf1_batchnorm_5153:(,
b4_cf1_conv2d_5157:(
batch_normalization_5162&
batch_normalization_5164:,&
batch_normalization_5166:,&
batch_normalization_5168:,

fc_d1_5173:,
batchnorm_d1_5176:
batchnorm_d1_5178:
batchnorm_d1_5180:
logits_5183:
logits_5185:
identity��(B1_CF1_BatchNorm/StatefulPartitionedCall�%B1_CF1_Conv2D/StatefulPartitionedCall�(B1_CF2_BatchNorm/StatefulPartitionedCall�%B1_CF2_Conv2D/StatefulPartitionedCall�(B2_CF1_BatchNorm/StatefulPartitionedCall�%B2_CF1_Conv2D/StatefulPartitionedCall�(B2_CF2_BatchNorm/StatefulPartitionedCall�%B2_CF2_Conv2D/StatefulPartitionedCall�(B3_CF1_BatchNorm/StatefulPartitionedCall�%B3_CF1_Conv2D/StatefulPartitionedCall�(B3_CF2_BatchNorm/StatefulPartitionedCall�%B3_CF2_Conv2D/StatefulPartitionedCall�(B4_CF1_BatchNorm/StatefulPartitionedCall�%B4_CF1_Conv2D/StatefulPartitionedCall�$BatchNorm-D1/StatefulPartitionedCall�FC-D1/StatefulPartitionedCall�Logits/StatefulPartitionedCall� Pre_Conv/StatefulPartitionedCall�'T1_CF_BatchNorm/StatefulPartitionedCall�$T1_CF_Conv2D/StatefulPartitionedCall�'T2_CF_BatchNorm/StatefulPartitionedCall�$T2_CF_Conv2D/StatefulPartitionedCall�'T3_CF_BatchNorm/StatefulPartitionedCall�$T3_CF_Conv2D/StatefulPartitionedCall�+batch_normalization/StatefulPartitionedCall_
tf.expand_dims/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B :�
tf.expand_dims/ExpandDims
ExpandDimsinput_1&tf.expand_dims/ExpandDims/dim:output:0*
T0*/
_output_shapes
:���������-C�
rescaling/PartitionedCallPartitionedCall"tf.expand_dims/ExpandDims:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_rescaling_layer_call_and_return_conditional_losses_2711�
 Pre_Conv/StatefulPartitionedCallStatefulPartitionedCall"rescaling/PartitionedCall:output:0pre_conv_5006*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *K
fFRD
B__inference_Pre_Conv_layer_call_and_return_conditional_losses_2720�
(B1_CF1_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall)Pre_Conv/StatefulPartitionedCall:output:0b1_cf1_batchnorm_5009b1_cf1_batchnorm_5011b1_cf1_batchnorm_5013b1_cf1_batchnorm_5015*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_2740�
B1_CF1_ReLu/PartitionedCallPartitionedCall1B1_CF1_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B1_CF1_ReLu_layer_call_and_return_conditional_losses_2755�
%B1_CF1_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B1_CF1_ReLu/PartitionedCall:output:0b1_cf1_conv2d_5019*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B1_CF1_Conv2D_layer_call_and_return_conditional_losses_2764�
B1_CF1_Dropout/PartitionedCallPartitionedCall.B1_CF1_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B1_CF1_Dropout_layer_call_and_return_conditional_losses_2773�
(B1_CF2_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall'B1_CF1_Dropout/PartitionedCall:output:0b1_cf2_batchnorm_5023b1_cf2_batchnorm_5025b1_cf2_batchnorm_5027b1_cf2_batchnorm_5029*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_2791�
B1_CF2_ReLu/PartitionedCallPartitionedCall1B1_CF2_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B1_CF2_ReLu_layer_call_and_return_conditional_losses_2806�
%B1_CF2_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B1_CF2_ReLu/PartitionedCall:output:0b1_cf2_conv2d_5033*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B1_CF2_Conv2D_layer_call_and_return_conditional_losses_2815�
B1_CF2_Dropout/PartitionedCallPartitionedCall.B1_CF2_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B1_CF2_Dropout_layer_call_and_return_conditional_losses_2824�
B1_Concat/PartitionedCallPartitionedCall)Pre_Conv/StatefulPartitionedCall:output:0'B1_CF1_Dropout/PartitionedCall:output:0'B1_CF2_Dropout/PartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_B1_Concat_layer_call_and_return_conditional_losses_2834�
'T1_CF_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall"B1_Concat/PartitionedCall:output:0t1_cf_batchnorm_5038t1_cf_batchnorm_5040t1_cf_batchnorm_5042t1_cf_batchnorm_5044*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_2852�
T1_CF_ReLu/PartitionedCallPartitionedCall0T1_CF_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *M
fHRF
D__inference_T1_CF_ReLu_layer_call_and_return_conditional_losses_2867�
$T1_CF_Conv2D/StatefulPartitionedCallStatefulPartitionedCall#T1_CF_ReLu/PartitionedCall:output:0t1_cf_conv2d_5048*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_T1_CF_Conv2D_layer_call_and_return_conditional_losses_2876�
T1_CF_Dropout/PartitionedCallPartitionedCall-T1_CF_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_T1_CF_Dropout_layer_call_and_return_conditional_losses_2885�
tf.compat.v1.pad/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
tf.compat.v1.pad/PadPad&T1_CF_Dropout/PartitionedCall:output:0&tf.compat.v1.pad/Pad/paddings:output:0*
T0*/
_output_shapes
:���������-E�
T1_Pool/PartitionedCallPartitionedCalltf.compat.v1.pad/Pad:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *J
fERC
A__inference_T1_Pool_layer_call_and_return_conditional_losses_2893�
(B2_CF1_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall T1_Pool/PartitionedCall:output:0b2_cf1_batchnorm_5055b2_cf1_batchnorm_5057b2_cf1_batchnorm_5059b2_cf1_batchnorm_5061*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_2911�
B2_CF1_ReLu/PartitionedCallPartitionedCall1B2_CF1_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B2_CF1_ReLu_layer_call_and_return_conditional_losses_2926�
%B2_CF1_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B2_CF1_ReLu/PartitionedCall:output:0b2_cf1_conv2d_5065*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B2_CF1_Conv2D_layer_call_and_return_conditional_losses_2935�
B2_CF1_Dropout/PartitionedCallPartitionedCall.B2_CF1_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B2_CF1_Dropout_layer_call_and_return_conditional_losses_2944�
(B2_CF2_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall'B2_CF1_Dropout/PartitionedCall:output:0b2_cf2_batchnorm_5069b2_cf2_batchnorm_5071b2_cf2_batchnorm_5073b2_cf2_batchnorm_5075*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_2962�
B2_CF2_ReLu/PartitionedCallPartitionedCall1B2_CF2_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B2_CF2_ReLu_layer_call_and_return_conditional_losses_2977�
%B2_CF2_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B2_CF2_ReLu/PartitionedCall:output:0b2_cf2_conv2d_5079*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B2_CF2_Conv2D_layer_call_and_return_conditional_losses_2986�
B2_CF2_Dropout/PartitionedCallPartitionedCall.B2_CF2_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B2_CF2_Dropout_layer_call_and_return_conditional_losses_2995�
B2_Concat/PartitionedCallPartitionedCall T1_Pool/PartitionedCall:output:0'B2_CF1_Dropout/PartitionedCall:output:0'B2_CF2_Dropout/PartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_B2_Concat_layer_call_and_return_conditional_losses_3005�
'T2_CF_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall"B2_Concat/PartitionedCall:output:0t2_cf_batchnorm_5084t2_cf_batchnorm_5086t2_cf_batchnorm_5088t2_cf_batchnorm_5090*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� *%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_3023�
T2_CF_ReLu/PartitionedCallPartitionedCall0T2_CF_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *M
fHRF
D__inference_T2_CF_ReLu_layer_call_and_return_conditional_losses_3038�
$T2_CF_Conv2D/StatefulPartitionedCallStatefulPartitionedCall#T2_CF_ReLu/PartitionedCall:output:0t2_cf_conv2d_5094*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� *#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_T2_CF_Conv2D_layer_call_and_return_conditional_losses_3047�
T2_CF_Dropout/PartitionedCallPartitionedCall-T2_CF_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_T2_CF_Dropout_layer_call_and_return_conditional_losses_3056�
tf.compat.v1.pad_1/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
tf.compat.v1.pad_1/PadPad&T2_CF_Dropout/PartitionedCall:output:0(tf.compat.v1.pad_1/Pad/paddings:output:0*
T0*/
_output_shapes
:��������� �
T2_Pool/PartitionedCallPartitionedCalltf.compat.v1.pad_1/Pad:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *J
fERC
A__inference_T2_Pool_layer_call_and_return_conditional_losses_3064�
(B3_CF1_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall T2_Pool/PartitionedCall:output:0b3_cf1_batchnorm_5101b3_cf1_batchnorm_5103b3_cf1_batchnorm_5105b3_cf1_batchnorm_5107*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� *%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_3082�
B3_CF1_ReLu/PartitionedCallPartitionedCall1B3_CF1_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B3_CF1_ReLu_layer_call_and_return_conditional_losses_3097�
%B3_CF1_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B3_CF1_ReLu/PartitionedCall:output:0b3_cf1_conv2d_5111*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B3_CF1_Conv2D_layer_call_and_return_conditional_losses_3106�
B3_CF1_Dropout/PartitionedCallPartitionedCall.B3_CF1_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B3_CF1_Dropout_layer_call_and_return_conditional_losses_3115�
(B3_CF2_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall'B3_CF1_Dropout/PartitionedCall:output:0b3_cf2_batchnorm_5115b3_cf2_batchnorm_5117b3_cf2_batchnorm_5119b3_cf2_batchnorm_5121*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_3133�
B3_CF2_ReLu/PartitionedCallPartitionedCall1B3_CF2_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B3_CF2_ReLu_layer_call_and_return_conditional_losses_3148�
%B3_CF2_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B3_CF2_ReLu/PartitionedCall:output:0b3_cf2_conv2d_5125*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B3_CF2_Conv2D_layer_call_and_return_conditional_losses_3157�
B3_CF2_Dropout/PartitionedCallPartitionedCall.B3_CF2_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B3_CF2_Dropout_layer_call_and_return_conditional_losses_3166�
B3_Concat/PartitionedCallPartitionedCall T2_Pool/PartitionedCall:output:0'B3_CF1_Dropout/PartitionedCall:output:0'B3_CF2_Dropout/PartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_B3_Concat_layer_call_and_return_conditional_losses_3176�
'T3_CF_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall"B3_Concat/PartitionedCall:output:0t3_cf_batchnorm_5130t3_cf_batchnorm_5132t3_cf_batchnorm_5134t3_cf_batchnorm_5136*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_3194�
T3_CF_ReLu/PartitionedCallPartitionedCall0T3_CF_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *M
fHRF
D__inference_T3_CF_ReLu_layer_call_and_return_conditional_losses_3209�
$T3_CF_Conv2D/StatefulPartitionedCallStatefulPartitionedCall#T3_CF_ReLu/PartitionedCall:output:0t3_cf_conv2d_5140*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_T3_CF_Conv2D_layer_call_and_return_conditional_losses_3218�
T3_CF_Dropout/PartitionedCallPartitionedCall-T3_CF_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_T3_CF_Dropout_layer_call_and_return_conditional_losses_3227�
tf.compat.v1.pad_2/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
tf.compat.v1.pad_2/PadPad&T3_CF_Dropout/PartitionedCall:output:0(tf.compat.v1.pad_2/Pad/paddings:output:0*
T0*/
_output_shapes
:���������	(�
T3_Pool/PartitionedCallPartitionedCalltf.compat.v1.pad_2/Pad:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *J
fERC
A__inference_T3_Pool_layer_call_and_return_conditional_losses_3235�
(B4_CF1_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall T3_Pool/PartitionedCall:output:0b4_cf1_batchnorm_5147b4_cf1_batchnorm_5149b4_cf1_batchnorm_5151b4_cf1_batchnorm_5153*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_3253�
B4_CF1_ReLu/PartitionedCallPartitionedCall1B4_CF1_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B4_CF1_ReLu_layer_call_and_return_conditional_losses_3268�
%B4_CF1_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B4_CF1_ReLu/PartitionedCall:output:0b4_cf1_conv2d_5157*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B4_CF1_Conv2D_layer_call_and_return_conditional_losses_3277�
B4_CF1_Dropout/PartitionedCallPartitionedCall.B4_CF1_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B4_CF1_Dropout_layer_call_and_return_conditional_losses_3286�
B4_Concat/PartitionedCallPartitionedCall T3_Pool/PartitionedCall:output:0'B4_CF1_Dropout/PartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������,* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_B4_Concat_layer_call_and_return_conditional_losses_3295�
+batch_normalization/StatefulPartitionedCallStatefulPartitionedCall"B4_Concat/PartitionedCall:output:0batch_normalization_5162batch_normalization_5164batch_normalization_5166batch_normalization_5168*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������,*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *V
fQRO
M__inference_batch_normalization_layer_call_and_return_conditional_losses_3313�
ReLu/PartitionedCallPartitionedCall4batch_normalization/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������,* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *G
fBR@
>__inference_ReLu_layer_call_and_return_conditional_losses_3328�
(global_average_pooling2d/PartitionedCallPartitionedCallReLu/PartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������,* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *[
fVRT
R__inference_global_average_pooling2d_layer_call_and_return_conditional_losses_3335�
FC-D1/StatefulPartitionedCallStatefulPartitionedCall1global_average_pooling2d/PartitionedCall:output:0
fc_d1_5173*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *H
fCRA
?__inference_FC-D1_layer_call_and_return_conditional_losses_3344�
$BatchNorm-D1/StatefulPartitionedCallStatefulPartitionedCall&FC-D1/StatefulPartitionedCall:output:0batchnorm_d1_5176batchnorm_d1_5178batchnorm_d1_5180*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_BatchNorm-D1_layer_call_and_return_conditional_losses_2657�
Logits/StatefulPartitionedCallStatefulPartitionedCall-BatchNorm-D1/StatefulPartitionedCall:output:0logits_5183logits_5185*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *I
fDRB
@__inference_Logits_layer_call_and_return_conditional_losses_3366v
IdentityIdentity'Logits/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:����������
NoOpNoOp)^B1_CF1_BatchNorm/StatefulPartitionedCall&^B1_CF1_Conv2D/StatefulPartitionedCall)^B1_CF2_BatchNorm/StatefulPartitionedCall&^B1_CF2_Conv2D/StatefulPartitionedCall)^B2_CF1_BatchNorm/StatefulPartitionedCall&^B2_CF1_Conv2D/StatefulPartitionedCall)^B2_CF2_BatchNorm/StatefulPartitionedCall&^B2_CF2_Conv2D/StatefulPartitionedCall)^B3_CF1_BatchNorm/StatefulPartitionedCall&^B3_CF1_Conv2D/StatefulPartitionedCall)^B3_CF2_BatchNorm/StatefulPartitionedCall&^B3_CF2_Conv2D/StatefulPartitionedCall)^B4_CF1_BatchNorm/StatefulPartitionedCall&^B4_CF1_Conv2D/StatefulPartitionedCall%^BatchNorm-D1/StatefulPartitionedCall^FC-D1/StatefulPartitionedCall^Logits/StatefulPartitionedCall!^Pre_Conv/StatefulPartitionedCall(^T1_CF_BatchNorm/StatefulPartitionedCall%^T1_CF_Conv2D/StatefulPartitionedCall(^T2_CF_BatchNorm/StatefulPartitionedCall%^T2_CF_Conv2D/StatefulPartitionedCall(^T3_CF_BatchNorm/StatefulPartitionedCall%^T3_CF_Conv2D/StatefulPartitionedCall,^batch_normalization/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*�
_input_shapes�
�:���������-C: :: : : : :: : : : :: : : : :: : : : :: : : : : : : : : : : : : : :: : : : :(: : : : :(: : : : :,: : : : : : : : : 2T
(B1_CF1_BatchNorm/StatefulPartitionedCall(B1_CF1_BatchNorm/StatefulPartitionedCall2N
%B1_CF1_Conv2D/StatefulPartitionedCall%B1_CF1_Conv2D/StatefulPartitionedCall2T
(B1_CF2_BatchNorm/StatefulPartitionedCall(B1_CF2_BatchNorm/StatefulPartitionedCall2N
%B1_CF2_Conv2D/StatefulPartitionedCall%B1_CF2_Conv2D/StatefulPartitionedCall2T
(B2_CF1_BatchNorm/StatefulPartitionedCall(B2_CF1_BatchNorm/StatefulPartitionedCall2N
%B2_CF1_Conv2D/StatefulPartitionedCall%B2_CF1_Conv2D/StatefulPartitionedCall2T
(B2_CF2_BatchNorm/StatefulPartitionedCall(B2_CF2_BatchNorm/StatefulPartitionedCall2N
%B2_CF2_Conv2D/StatefulPartitionedCall%B2_CF2_Conv2D/StatefulPartitionedCall2T
(B3_CF1_BatchNorm/StatefulPartitionedCall(B3_CF1_BatchNorm/StatefulPartitionedCall2N
%B3_CF1_Conv2D/StatefulPartitionedCall%B3_CF1_Conv2D/StatefulPartitionedCall2T
(B3_CF2_BatchNorm/StatefulPartitionedCall(B3_CF2_BatchNorm/StatefulPartitionedCall2N
%B3_CF2_Conv2D/StatefulPartitionedCall%B3_CF2_Conv2D/StatefulPartitionedCall2T
(B4_CF1_BatchNorm/StatefulPartitionedCall(B4_CF1_BatchNorm/StatefulPartitionedCall2N
%B4_CF1_Conv2D/StatefulPartitionedCall%B4_CF1_Conv2D/StatefulPartitionedCall2L
$BatchNorm-D1/StatefulPartitionedCall$BatchNorm-D1/StatefulPartitionedCall2>
FC-D1/StatefulPartitionedCallFC-D1/StatefulPartitionedCall2@
Logits/StatefulPartitionedCallLogits/StatefulPartitionedCall2D
 Pre_Conv/StatefulPartitionedCall Pre_Conv/StatefulPartitionedCall2R
'T1_CF_BatchNorm/StatefulPartitionedCall'T1_CF_BatchNorm/StatefulPartitionedCall2L
$T1_CF_Conv2D/StatefulPartitionedCall$T1_CF_Conv2D/StatefulPartitionedCall2R
'T2_CF_BatchNorm/StatefulPartitionedCall'T2_CF_BatchNorm/StatefulPartitionedCall2L
$T2_CF_Conv2D/StatefulPartitionedCall$T2_CF_Conv2D/StatefulPartitionedCall2R
'T3_CF_BatchNorm/StatefulPartitionedCall'T3_CF_BatchNorm/StatefulPartitionedCall2L
$T3_CF_Conv2D/StatefulPartitionedCall$T3_CF_Conv2D/StatefulPartitionedCall2Z
+batch_normalization/StatefulPartitionedCall+batch_normalization/StatefulPartitionedCall:T P
+
_output_shapes
:���������-C
!
_user_specified_name	input_1: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
: :  

_output_shapes
: : %

_output_shapes
:: *

_output_shapes
:(: /

_output_shapes
:(: 4

_output_shapes
:,
�
�
/__inference_B1_CF1_BatchNorm_layer_call_fn_6266

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_2740w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������-C`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������-C:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:
�	
�
.__inference_T2_CF_BatchNorm_layer_call_fn_7145

inputs
unknown
	unknown_0: 
	unknown_1: 
	unknown_2: 
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+��������������������������� *%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_2248�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+��������������������������� `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+��������������������������� : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+��������������������������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
�
G__inference_B2_CF1_Conv2D_layer_call_and_return_conditional_losses_6919

inputs8
conv2d_readvariableop_resource:
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
:*
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������*
paddingSAME*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:���������^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������: 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_6704

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������-C:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������-C�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������-C:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:
�
e
,__inference_T2_CF_Dropout_layer_call_fn_7286

inputs
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_T2_CF_Dropout_layer_call_and_return_conditional_losses_3935w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:��������� `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:��������� 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs
�
}
C__inference_B2_Concat_layer_call_and_return_conditional_losses_7132
inputs_0
inputs_1
inputs_2
identityM
concat/axisConst*
_output_shapes
: *
dtype0*
value	B :�
concatConcatV2inputs_0inputs_1inputs_2concat/axis:output:0*
N*
T0*/
_output_shapes
:��������� _
IdentityIdentityconcat:output:0*
T0*/
_output_shapes
:��������� "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*d
_input_shapesS
Q:���������:���������:���������:Y U
/
_output_shapes
:���������
"
_user_specified_name
inputs/0:YU
/
_output_shapes
:���������
"
_user_specified_name
inputs/1:YU
/
_output_shapes
:���������
"
_user_specified_name
inputs/2
�
�
"__inference_signature_wrapper_1133

inputs!
unknown:
	unknown_0
	unknown_1:
	unknown_2:
	unknown_3:#
	unknown_4:
	unknown_5
	unknown_6:
	unknown_7:
	unknown_8:#
	unknown_9:

unknown_10

unknown_11:

unknown_12:

unknown_13:$

unknown_14:

unknown_15

unknown_16:

unknown_17:

unknown_18:$

unknown_19:

unknown_20

unknown_21:

unknown_22:

unknown_23:$

unknown_24:

unknown_25

unknown_26: 

unknown_27: 

unknown_28: $

unknown_29:  

unknown_30

unknown_31: 

unknown_32: 

unknown_33: $

unknown_34: 

unknown_35

unknown_36:

unknown_37:

unknown_38:$

unknown_39:

unknown_40

unknown_41:(

unknown_42:(

unknown_43:($

unknown_44:((

unknown_45

unknown_46:(

unknown_47:(

unknown_48:($

unknown_49:(

unknown_50

unknown_51:,

unknown_52:,

unknown_53:,

unknown_54:,

unknown_55:

unknown_56:

unknown_57:

unknown_58:

unknown_59:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4	unknown_5	unknown_6	unknown_7	unknown_8	unknown_9
unknown_10
unknown_11
unknown_12
unknown_13
unknown_14
unknown_15
unknown_16
unknown_17
unknown_18
unknown_19
unknown_20
unknown_21
unknown_22
unknown_23
unknown_24
unknown_25
unknown_26
unknown_27
unknown_28
unknown_29
unknown_30
unknown_31
unknown_32
unknown_33
unknown_34
unknown_35
unknown_36
unknown_37
unknown_38
unknown_39
unknown_40
unknown_41
unknown_42
unknown_43
unknown_44
unknown_45
unknown_46
unknown_47
unknown_48
unknown_49
unknown_50
unknown_51
unknown_52
unknown_53
unknown_54
unknown_55
unknown_56
unknown_57
unknown_58
unknown_59*I
TinB
@2>*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*T
_read_only_resource_inputs6
42	
!"#$&'()+,-.012356789:;<=*-
config_proto

CPU

GPU 2J 8� *
fR
__inference_basic_1004o
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*�
_input_shapes�
�:���������-C: :: : : : :: : : : :: : : : :: : : : :: : : : : : : : : : : : : : :: : : : :(: : : : :(: : : : :,: : : : : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:S O
+
_output_shapes
:���������-C
 
_user_specified_nameinputs: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
: :  

_output_shapes
: : %

_output_shapes
:: *

_output_shapes
:(: /

_output_shapes
:(: 4

_output_shapes
:,
�
�
/__inference_B2_CF2_BatchNorm_layer_call_fn_6998

inputs
unknown
	unknown_0:
	unknown_1:
	unknown_2:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_4072w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������:: : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs: 

_output_shapes
:
�
�
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_7235

inputs	
scale%
readvariableop_resource: 6
(fusedbatchnormv3_readvariableop_resource: 8
*fusedbatchnormv3_readvariableop_1_resource: 
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
: *
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
: *
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:��������� : : : : :*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:��������� �
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':��������� : : : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:��������� 
 
_user_specified_nameinputs: 

_output_shapes
: 
�
]
A__inference_T3_Pool_layer_call_and_return_conditional_losses_3235

inputs
identity�
AvgPoolAvgPoolinputs*
T0*/
_output_shapes
:���������(*
ksize
*
paddingVALID*
strides
`
IdentityIdentityAvgPool:output:0*
T0*/
_output_shapes
:���������("
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������	(:W S
/
_output_shapes
:���������	(
 
_user_specified_nameinputs
�

g
H__inference_B2_CF1_Dropout_layer_call_and_return_conditional_losses_6946

inputs
identity�R
dropout/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *���?l
dropout/MulMulinputsdropout/Const:output:0*
T0*/
_output_shapes
:���������C
dropout/ShapeShapeinputs*
T0*
_output_shapes
:�
$dropout/random_uniform/RandomUniformRandomUniformdropout/Shape:output:0*
T0*/
_output_shapes
:���������*
dtype0[
dropout/GreaterEqual/yConst*
_output_shapes
: *
dtype0*
valueB
 *��L=�
dropout/GreaterEqualGreaterEqual-dropout/random_uniform/RandomUniform:output:0dropout/GreaterEqual/y:output:0*
T0*/
_output_shapes
:���������w
dropout/CastCastdropout/GreaterEqual:z:0*

DstT0*

SrcT0
*/
_output_shapes
:���������q
dropout/Mul_1Muldropout/Mul:z:0dropout/Cast:y:0*
T0*/
_output_shapes
:���������a
IdentityIdentitydropout/Mul_1:z:0*
T0*/
_output_shapes
:���������"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
.__inference_T3_CF_BatchNorm_layer_call_fn_7719

inputs
unknown
	unknown_0:(
	unknown_1:(
	unknown_2:(
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_3194w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������(`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������(:(: : : 22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�
�
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_7783

inputs	
scale%
readvariableop_resource:(6
(fusedbatchnormv3_readvariableop_resource:(8
*fusedbatchnormv3_readvariableop_1_resource:(
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������(:(:(:(:(:*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������(�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������(:(: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�
�
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_7940

inputs	
scale%
readvariableop_resource:(6
(fusedbatchnormv3_readvariableop_resource:(8
*fusedbatchnormv3_readvariableop_1_resource:(
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*]
_output_shapesK
I:+���������������������������(:(:(:(:(:*
epsilon%o�:*
is_training( }
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������(�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������(:(: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:i e
A
_output_shapes/
-:+���������������������������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�
�
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_3194

inputs	
scale%
readvariableop_resource:(6
(fusedbatchnormv3_readvariableop_resource:(8
*fusedbatchnormv3_readvariableop_1_resource:(
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:(*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:(*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������(:(:(:(:(:*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:���������(�
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������(:(: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs: 

_output_shapes
:(
�
�
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_7597

inputs	
scale%
readvariableop_resource:6
(fusedbatchnormv3_readvariableop_resource:8
*fusedbatchnormv3_readvariableop_1_resource:
identity��FusedBatchNormV3/ReadVariableOp�!FusedBatchNormV3/ReadVariableOp_1�ReadVariableOpb
ReadVariableOpReadVariableOpreadvariableop_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3/ReadVariableOpReadVariableOp(fusedbatchnormv3_readvariableop_resource*
_output_shapes
:*
dtype0�
!FusedBatchNormV3/ReadVariableOp_1ReadVariableOp*fusedbatchnormv3_readvariableop_1_resource*
_output_shapes
:*
dtype0�
FusedBatchNormV3FusedBatchNormV3inputsscaleReadVariableOp:value:0'FusedBatchNormV3/ReadVariableOp:value:0)FusedBatchNormV3/ReadVariableOp_1:value:0*
T0*
U0*K
_output_shapes9
7:���������:::::*
epsilon%o�:*
is_training( k
IdentityIdentityFusedBatchNormV3:y:0^NoOp*
T0*/
_output_shapes
:����������
NoOpNoOp ^FusedBatchNormV3/ReadVariableOp"^FusedBatchNormV3/ReadVariableOp_1^ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*:
_input_shapes)
':���������:: : : 2B
FusedBatchNormV3/ReadVariableOpFusedBatchNormV3/ReadVariableOp2F
!FusedBatchNormV3/ReadVariableOp_1!FusedBatchNormV3/ReadVariableOp_12 
ReadVariableOpReadVariableOp:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs: 

_output_shapes
:
�
n
R__inference_global_average_pooling2d_layer_call_and_return_conditional_losses_3335

inputs
identityg
Mean/reduction_indicesConst*
_output_shapes
:*
dtype0*
valueB"      g
MeanMeaninputsMean/reduction_indices:output:0*
T0*'
_output_shapes
:���������,U
IdentityIdentityMean:output:0*
T0*'
_output_shapes
:���������,"
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������,:W S
/
_output_shapes
:���������,
 
_user_specified_nameinputs
�
�
B__inference_DenseNet_layer_call_and_return_conditional_losses_5378
input_1'
pre_conv_5195:
b1_cf1_batchnorm_5198#
b1_cf1_batchnorm_5200:#
b1_cf1_batchnorm_5202:#
b1_cf1_batchnorm_5204:,
b1_cf1_conv2d_5208:
b1_cf2_batchnorm_5212#
b1_cf2_batchnorm_5214:#
b1_cf2_batchnorm_5216:#
b1_cf2_batchnorm_5218:,
b1_cf2_conv2d_5222:
t1_cf_batchnorm_5227"
t1_cf_batchnorm_5229:"
t1_cf_batchnorm_5231:"
t1_cf_batchnorm_5233:+
t1_cf_conv2d_5237:
b2_cf1_batchnorm_5244#
b2_cf1_batchnorm_5246:#
b2_cf1_batchnorm_5248:#
b2_cf1_batchnorm_5250:,
b2_cf1_conv2d_5254:
b2_cf2_batchnorm_5258#
b2_cf2_batchnorm_5260:#
b2_cf2_batchnorm_5262:#
b2_cf2_batchnorm_5264:,
b2_cf2_conv2d_5268:
t2_cf_batchnorm_5273"
t2_cf_batchnorm_5275: "
t2_cf_batchnorm_5277: "
t2_cf_batchnorm_5279: +
t2_cf_conv2d_5283:  
b3_cf1_batchnorm_5290#
b3_cf1_batchnorm_5292: #
b3_cf1_batchnorm_5294: #
b3_cf1_batchnorm_5296: ,
b3_cf1_conv2d_5300: 
b3_cf2_batchnorm_5304#
b3_cf2_batchnorm_5306:#
b3_cf2_batchnorm_5308:#
b3_cf2_batchnorm_5310:,
b3_cf2_conv2d_5314:
t3_cf_batchnorm_5319"
t3_cf_batchnorm_5321:("
t3_cf_batchnorm_5323:("
t3_cf_batchnorm_5325:(+
t3_cf_conv2d_5329:((
b4_cf1_batchnorm_5336#
b4_cf1_batchnorm_5338:(#
b4_cf1_batchnorm_5340:(#
b4_cf1_batchnorm_5342:(,
b4_cf1_conv2d_5346:(
batch_normalization_5351&
batch_normalization_5353:,&
batch_normalization_5355:,&
batch_normalization_5357:,

fc_d1_5362:,
batchnorm_d1_5365:
batchnorm_d1_5367:
batchnorm_d1_5369:
logits_5372:
logits_5374:
identity��(B1_CF1_BatchNorm/StatefulPartitionedCall�%B1_CF1_Conv2D/StatefulPartitionedCall�&B1_CF1_Dropout/StatefulPartitionedCall�(B1_CF2_BatchNorm/StatefulPartitionedCall�%B1_CF2_Conv2D/StatefulPartitionedCall�&B1_CF2_Dropout/StatefulPartitionedCall�(B2_CF1_BatchNorm/StatefulPartitionedCall�%B2_CF1_Conv2D/StatefulPartitionedCall�&B2_CF1_Dropout/StatefulPartitionedCall�(B2_CF2_BatchNorm/StatefulPartitionedCall�%B2_CF2_Conv2D/StatefulPartitionedCall�&B2_CF2_Dropout/StatefulPartitionedCall�(B3_CF1_BatchNorm/StatefulPartitionedCall�%B3_CF1_Conv2D/StatefulPartitionedCall�&B3_CF1_Dropout/StatefulPartitionedCall�(B3_CF2_BatchNorm/StatefulPartitionedCall�%B3_CF2_Conv2D/StatefulPartitionedCall�&B3_CF2_Dropout/StatefulPartitionedCall�(B4_CF1_BatchNorm/StatefulPartitionedCall�%B4_CF1_Conv2D/StatefulPartitionedCall�&B4_CF1_Dropout/StatefulPartitionedCall�$BatchNorm-D1/StatefulPartitionedCall�FC-D1/StatefulPartitionedCall�Logits/StatefulPartitionedCall� Pre_Conv/StatefulPartitionedCall�'T1_CF_BatchNorm/StatefulPartitionedCall�$T1_CF_Conv2D/StatefulPartitionedCall�%T1_CF_Dropout/StatefulPartitionedCall�'T2_CF_BatchNorm/StatefulPartitionedCall�$T2_CF_Conv2D/StatefulPartitionedCall�%T2_CF_Dropout/StatefulPartitionedCall�'T3_CF_BatchNorm/StatefulPartitionedCall�$T3_CF_Conv2D/StatefulPartitionedCall�%T3_CF_Dropout/StatefulPartitionedCall�+batch_normalization/StatefulPartitionedCall_
tf.expand_dims/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B :�
tf.expand_dims/ExpandDims
ExpandDimsinput_1&tf.expand_dims/ExpandDims/dim:output:0*
T0*/
_output_shapes
:���������-C�
rescaling/PartitionedCallPartitionedCall"tf.expand_dims/ExpandDims:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_rescaling_layer_call_and_return_conditional_losses_2711�
 Pre_Conv/StatefulPartitionedCallStatefulPartitionedCall"rescaling/PartitionedCall:output:0pre_conv_5195*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *K
fFRD
B__inference_Pre_Conv_layer_call_and_return_conditional_losses_2720�
(B1_CF1_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall)Pre_Conv/StatefulPartitionedCall:output:0b1_cf1_batchnorm_5198b1_cf1_batchnorm_5200b1_cf1_batchnorm_5202b1_cf1_batchnorm_5204*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_4405�
B1_CF1_ReLu/PartitionedCallPartitionedCall1B1_CF1_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B1_CF1_ReLu_layer_call_and_return_conditional_losses_2755�
%B1_CF1_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B1_CF1_ReLu/PartitionedCall:output:0b1_cf1_conv2d_5208*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B1_CF1_Conv2D_layer_call_and_return_conditional_losses_2764�
&B1_CF1_Dropout/StatefulPartitionedCallStatefulPartitionedCall.B1_CF1_Conv2D/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B1_CF1_Dropout_layer_call_and_return_conditional_losses_4356�
(B1_CF2_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall/B1_CF1_Dropout/StatefulPartitionedCall:output:0b1_cf2_batchnorm_5212b1_cf2_batchnorm_5214b1_cf2_batchnorm_5216b1_cf2_batchnorm_5218*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_4325�
B1_CF2_ReLu/PartitionedCallPartitionedCall1B1_CF2_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B1_CF2_ReLu_layer_call_and_return_conditional_losses_2806�
%B1_CF2_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B1_CF2_ReLu/PartitionedCall:output:0b1_cf2_conv2d_5222*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B1_CF2_Conv2D_layer_call_and_return_conditional_losses_2815�
&B1_CF2_Dropout/StatefulPartitionedCallStatefulPartitionedCall.B1_CF2_Conv2D/StatefulPartitionedCall:output:0'^B1_CF1_Dropout/StatefulPartitionedCall*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B1_CF2_Dropout_layer_call_and_return_conditional_losses_4276�
B1_Concat/PartitionedCallPartitionedCall)Pre_Conv/StatefulPartitionedCall:output:0/B1_CF1_Dropout/StatefulPartitionedCall:output:0/B1_CF2_Dropout/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_B1_Concat_layer_call_and_return_conditional_losses_2834�
'T1_CF_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall"B1_Concat/PartitionedCall:output:0t1_cf_batchnorm_5227t1_cf_batchnorm_5229t1_cf_batchnorm_5231t1_cf_batchnorm_5233*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_4237�
T1_CF_ReLu/PartitionedCallPartitionedCall0T1_CF_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *M
fHRF
D__inference_T1_CF_ReLu_layer_call_and_return_conditional_losses_2867�
$T1_CF_Conv2D/StatefulPartitionedCallStatefulPartitionedCall#T1_CF_ReLu/PartitionedCall:output:0t1_cf_conv2d_5237*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_T1_CF_Conv2D_layer_call_and_return_conditional_losses_2876�
%T1_CF_Dropout/StatefulPartitionedCallStatefulPartitionedCall-T1_CF_Conv2D/StatefulPartitionedCall:output:0'^B1_CF2_Dropout/StatefulPartitionedCall*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������-C* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_T1_CF_Dropout_layer_call_and_return_conditional_losses_4188�
tf.compat.v1.pad/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
tf.compat.v1.pad/PadPad.T1_CF_Dropout/StatefulPartitionedCall:output:0&tf.compat.v1.pad/Pad/paddings:output:0*
T0*/
_output_shapes
:���������-E�
T1_Pool/PartitionedCallPartitionedCalltf.compat.v1.pad/Pad:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *J
fERC
A__inference_T1_Pool_layer_call_and_return_conditional_losses_2893�
(B2_CF1_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall T1_Pool/PartitionedCall:output:0b2_cf1_batchnorm_5244b2_cf1_batchnorm_5246b2_cf1_batchnorm_5248b2_cf1_batchnorm_5250*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_4152�
B2_CF1_ReLu/PartitionedCallPartitionedCall1B2_CF1_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B2_CF1_ReLu_layer_call_and_return_conditional_losses_2926�
%B2_CF1_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B2_CF1_ReLu/PartitionedCall:output:0b2_cf1_conv2d_5254*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B2_CF1_Conv2D_layer_call_and_return_conditional_losses_2935�
&B2_CF1_Dropout/StatefulPartitionedCallStatefulPartitionedCall.B2_CF1_Conv2D/StatefulPartitionedCall:output:0&^T1_CF_Dropout/StatefulPartitionedCall*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B2_CF1_Dropout_layer_call_and_return_conditional_losses_4103�
(B2_CF2_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall/B2_CF1_Dropout/StatefulPartitionedCall:output:0b2_cf2_batchnorm_5258b2_cf2_batchnorm_5260b2_cf2_batchnorm_5262b2_cf2_batchnorm_5264*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_4072�
B2_CF2_ReLu/PartitionedCallPartitionedCall1B2_CF2_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B2_CF2_ReLu_layer_call_and_return_conditional_losses_2977�
%B2_CF2_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B2_CF2_ReLu/PartitionedCall:output:0b2_cf2_conv2d_5268*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B2_CF2_Conv2D_layer_call_and_return_conditional_losses_2986�
&B2_CF2_Dropout/StatefulPartitionedCallStatefulPartitionedCall.B2_CF2_Conv2D/StatefulPartitionedCall:output:0'^B2_CF1_Dropout/StatefulPartitionedCall*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B2_CF2_Dropout_layer_call_and_return_conditional_losses_4023�
B2_Concat/PartitionedCallPartitionedCall T1_Pool/PartitionedCall:output:0/B2_CF1_Dropout/StatefulPartitionedCall:output:0/B2_CF2_Dropout/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_B2_Concat_layer_call_and_return_conditional_losses_3005�
'T2_CF_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall"B2_Concat/PartitionedCall:output:0t2_cf_batchnorm_5273t2_cf_batchnorm_5275t2_cf_batchnorm_5277t2_cf_batchnorm_5279*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� *%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_3984�
T2_CF_ReLu/PartitionedCallPartitionedCall0T2_CF_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *M
fHRF
D__inference_T2_CF_ReLu_layer_call_and_return_conditional_losses_3038�
$T2_CF_Conv2D/StatefulPartitionedCallStatefulPartitionedCall#T2_CF_ReLu/PartitionedCall:output:0t2_cf_conv2d_5283*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� *#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_T2_CF_Conv2D_layer_call_and_return_conditional_losses_3047�
%T2_CF_Dropout/StatefulPartitionedCallStatefulPartitionedCall-T2_CF_Conv2D/StatefulPartitionedCall:output:0'^B2_CF2_Dropout/StatefulPartitionedCall*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_T2_CF_Dropout_layer_call_and_return_conditional_losses_3935�
tf.compat.v1.pad_1/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
tf.compat.v1.pad_1/PadPad.T2_CF_Dropout/StatefulPartitionedCall:output:0(tf.compat.v1.pad_1/Pad/paddings:output:0*
T0*/
_output_shapes
:��������� �
T2_Pool/PartitionedCallPartitionedCalltf.compat.v1.pad_1/Pad:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *J
fERC
A__inference_T2_Pool_layer_call_and_return_conditional_losses_3064�
(B3_CF1_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall T2_Pool/PartitionedCall:output:0b3_cf1_batchnorm_5290b3_cf1_batchnorm_5292b3_cf1_batchnorm_5294b3_cf1_batchnorm_5296*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� *%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_3899�
B3_CF1_ReLu/PartitionedCallPartitionedCall1B3_CF1_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:��������� * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B3_CF1_ReLu_layer_call_and_return_conditional_losses_3097�
%B3_CF1_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B3_CF1_ReLu/PartitionedCall:output:0b3_cf1_conv2d_5300*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B3_CF1_Conv2D_layer_call_and_return_conditional_losses_3106�
&B3_CF1_Dropout/StatefulPartitionedCallStatefulPartitionedCall.B3_CF1_Conv2D/StatefulPartitionedCall:output:0&^T2_CF_Dropout/StatefulPartitionedCall*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B3_CF1_Dropout_layer_call_and_return_conditional_losses_3850�
(B3_CF2_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall/B3_CF1_Dropout/StatefulPartitionedCall:output:0b3_cf2_batchnorm_5304b3_cf2_batchnorm_5306b3_cf2_batchnorm_5308b3_cf2_batchnorm_5310*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_3819�
B3_CF2_ReLu/PartitionedCallPartitionedCall1B3_CF2_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B3_CF2_ReLu_layer_call_and_return_conditional_losses_3148�
%B3_CF2_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B3_CF2_ReLu/PartitionedCall:output:0b3_cf2_conv2d_5314*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B3_CF2_Conv2D_layer_call_and_return_conditional_losses_3157�
&B3_CF2_Dropout/StatefulPartitionedCallStatefulPartitionedCall.B3_CF2_Conv2D/StatefulPartitionedCall:output:0'^B3_CF1_Dropout/StatefulPartitionedCall*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B3_CF2_Dropout_layer_call_and_return_conditional_losses_3770�
B3_Concat/PartitionedCallPartitionedCall T2_Pool/PartitionedCall:output:0/B3_CF1_Dropout/StatefulPartitionedCall:output:0/B3_CF2_Dropout/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_B3_Concat_layer_call_and_return_conditional_losses_3176�
'T3_CF_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall"B3_Concat/PartitionedCall:output:0t3_cf_batchnorm_5319t3_cf_batchnorm_5321t3_cf_batchnorm_5323t3_cf_batchnorm_5325*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_3731�
T3_CF_ReLu/PartitionedCallPartitionedCall0T3_CF_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *M
fHRF
D__inference_T3_CF_ReLu_layer_call_and_return_conditional_losses_3209�
$T3_CF_Conv2D/StatefulPartitionedCallStatefulPartitionedCall#T3_CF_ReLu/PartitionedCall:output:0t3_cf_conv2d_5329*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_T3_CF_Conv2D_layer_call_and_return_conditional_losses_3218�
%T3_CF_Dropout/StatefulPartitionedCallStatefulPartitionedCall-T3_CF_Conv2D/StatefulPartitionedCall:output:0'^B3_CF2_Dropout/StatefulPartitionedCall*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_T3_CF_Dropout_layer_call_and_return_conditional_losses_3682�
tf.compat.v1.pad_2/Pad/paddingsConst*
_output_shapes

:*
dtype0*9
value0B."                                �
tf.compat.v1.pad_2/PadPad.T3_CF_Dropout/StatefulPartitionedCall:output:0(tf.compat.v1.pad_2/Pad/paddings:output:0*
T0*/
_output_shapes
:���������	(�
T3_Pool/PartitionedCallPartitionedCalltf.compat.v1.pad_2/Pad:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *J
fERC
A__inference_T3_Pool_layer_call_and_return_conditional_losses_3235�
(B4_CF1_BatchNorm/StatefulPartitionedCallStatefulPartitionedCall T3_Pool/PartitionedCall:output:0b4_cf1_batchnorm_5336b4_cf1_batchnorm_5338b4_cf1_batchnorm_5340b4_cf1_batchnorm_5342*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *S
fNRL
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_3646�
B4_CF1_ReLu/PartitionedCallPartitionedCall1B4_CF1_BatchNorm/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B4_CF1_ReLu_layer_call_and_return_conditional_losses_3268�
%B4_CF1_Conv2D/StatefulPartitionedCallStatefulPartitionedCall$B4_CF1_ReLu/PartitionedCall:output:0b4_cf1_conv2d_5346*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *P
fKRI
G__inference_B4_CF1_Conv2D_layer_call_and_return_conditional_losses_3277�
&B4_CF1_Dropout/StatefulPartitionedCallStatefulPartitionedCall.B4_CF1_Conv2D/StatefulPartitionedCall:output:0&^T3_CF_Dropout/StatefulPartitionedCall*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B4_CF1_Dropout_layer_call_and_return_conditional_losses_3597�
B4_Concat/PartitionedCallPartitionedCall T3_Pool/PartitionedCall:output:0/B4_CF1_Dropout/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������,* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *L
fGRE
C__inference_B4_Concat_layer_call_and_return_conditional_losses_3295�
+batch_normalization/StatefulPartitionedCallStatefulPartitionedCall"B4_Concat/PartitionedCall:output:0batch_normalization_5351batch_normalization_5353batch_normalization_5355batch_normalization_5357*
Tin	
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������,*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *V
fQRO
M__inference_batch_normalization_layer_call_and_return_conditional_losses_3559�
ReLu/PartitionedCallPartitionedCall4batch_normalization/StatefulPartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������,* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *G
fBR@
>__inference_ReLu_layer_call_and_return_conditional_losses_3328�
(global_average_pooling2d/PartitionedCallPartitionedCallReLu/PartitionedCall:output:0*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������,* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *[
fVRT
R__inference_global_average_pooling2d_layer_call_and_return_conditional_losses_3335�
FC-D1/StatefulPartitionedCallStatefulPartitionedCall1global_average_pooling2d/PartitionedCall:output:0
fc_d1_5362*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*#
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *H
fCRA
?__inference_FC-D1_layer_call_and_return_conditional_losses_3344�
$BatchNorm-D1/StatefulPartitionedCallStatefulPartitionedCall&FC-D1/StatefulPartitionedCall:output:0batchnorm_d1_5365batchnorm_d1_5367batchnorm_d1_5369*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *O
fJRH
F__inference_BatchNorm-D1_layer_call_and_return_conditional_losses_2685�
Logits/StatefulPartitionedCallStatefulPartitionedCall-BatchNorm-D1/StatefulPartitionedCall:output:0logits_5372logits_5374*
Tin
2*
Tout
2*
_collective_manager_ids
 *'
_output_shapes
:���������*$
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *I
fDRB
@__inference_Logits_layer_call_and_return_conditional_losses_3366v
IdentityIdentity'Logits/StatefulPartitionedCall:output:0^NoOp*
T0*'
_output_shapes
:����������
NoOpNoOp)^B1_CF1_BatchNorm/StatefulPartitionedCall&^B1_CF1_Conv2D/StatefulPartitionedCall'^B1_CF1_Dropout/StatefulPartitionedCall)^B1_CF2_BatchNorm/StatefulPartitionedCall&^B1_CF2_Conv2D/StatefulPartitionedCall'^B1_CF2_Dropout/StatefulPartitionedCall)^B2_CF1_BatchNorm/StatefulPartitionedCall&^B2_CF1_Conv2D/StatefulPartitionedCall'^B2_CF1_Dropout/StatefulPartitionedCall)^B2_CF2_BatchNorm/StatefulPartitionedCall&^B2_CF2_Conv2D/StatefulPartitionedCall'^B2_CF2_Dropout/StatefulPartitionedCall)^B3_CF1_BatchNorm/StatefulPartitionedCall&^B3_CF1_Conv2D/StatefulPartitionedCall'^B3_CF1_Dropout/StatefulPartitionedCall)^B3_CF2_BatchNorm/StatefulPartitionedCall&^B3_CF2_Conv2D/StatefulPartitionedCall'^B3_CF2_Dropout/StatefulPartitionedCall)^B4_CF1_BatchNorm/StatefulPartitionedCall&^B4_CF1_Conv2D/StatefulPartitionedCall'^B4_CF1_Dropout/StatefulPartitionedCall%^BatchNorm-D1/StatefulPartitionedCall^FC-D1/StatefulPartitionedCall^Logits/StatefulPartitionedCall!^Pre_Conv/StatefulPartitionedCall(^T1_CF_BatchNorm/StatefulPartitionedCall%^T1_CF_Conv2D/StatefulPartitionedCall&^T1_CF_Dropout/StatefulPartitionedCall(^T2_CF_BatchNorm/StatefulPartitionedCall%^T2_CF_Conv2D/StatefulPartitionedCall&^T2_CF_Dropout/StatefulPartitionedCall(^T3_CF_BatchNorm/StatefulPartitionedCall%^T3_CF_Conv2D/StatefulPartitionedCall&^T3_CF_Dropout/StatefulPartitionedCall,^batch_normalization/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*�
_input_shapes�
�:���������-C: :: : : : :: : : : :: : : : :: : : : :: : : : : : : : : : : : : : :: : : : :(: : : : :(: : : : :,: : : : : : : : : 2T
(B1_CF1_BatchNorm/StatefulPartitionedCall(B1_CF1_BatchNorm/StatefulPartitionedCall2N
%B1_CF1_Conv2D/StatefulPartitionedCall%B1_CF1_Conv2D/StatefulPartitionedCall2P
&B1_CF1_Dropout/StatefulPartitionedCall&B1_CF1_Dropout/StatefulPartitionedCall2T
(B1_CF2_BatchNorm/StatefulPartitionedCall(B1_CF2_BatchNorm/StatefulPartitionedCall2N
%B1_CF2_Conv2D/StatefulPartitionedCall%B1_CF2_Conv2D/StatefulPartitionedCall2P
&B1_CF2_Dropout/StatefulPartitionedCall&B1_CF2_Dropout/StatefulPartitionedCall2T
(B2_CF1_BatchNorm/StatefulPartitionedCall(B2_CF1_BatchNorm/StatefulPartitionedCall2N
%B2_CF1_Conv2D/StatefulPartitionedCall%B2_CF1_Conv2D/StatefulPartitionedCall2P
&B2_CF1_Dropout/StatefulPartitionedCall&B2_CF1_Dropout/StatefulPartitionedCall2T
(B2_CF2_BatchNorm/StatefulPartitionedCall(B2_CF2_BatchNorm/StatefulPartitionedCall2N
%B2_CF2_Conv2D/StatefulPartitionedCall%B2_CF2_Conv2D/StatefulPartitionedCall2P
&B2_CF2_Dropout/StatefulPartitionedCall&B2_CF2_Dropout/StatefulPartitionedCall2T
(B3_CF1_BatchNorm/StatefulPartitionedCall(B3_CF1_BatchNorm/StatefulPartitionedCall2N
%B3_CF1_Conv2D/StatefulPartitionedCall%B3_CF1_Conv2D/StatefulPartitionedCall2P
&B3_CF1_Dropout/StatefulPartitionedCall&B3_CF1_Dropout/StatefulPartitionedCall2T
(B3_CF2_BatchNorm/StatefulPartitionedCall(B3_CF2_BatchNorm/StatefulPartitionedCall2N
%B3_CF2_Conv2D/StatefulPartitionedCall%B3_CF2_Conv2D/StatefulPartitionedCall2P
&B3_CF2_Dropout/StatefulPartitionedCall&B3_CF2_Dropout/StatefulPartitionedCall2T
(B4_CF1_BatchNorm/StatefulPartitionedCall(B4_CF1_BatchNorm/StatefulPartitionedCall2N
%B4_CF1_Conv2D/StatefulPartitionedCall%B4_CF1_Conv2D/StatefulPartitionedCall2P
&B4_CF1_Dropout/StatefulPartitionedCall&B4_CF1_Dropout/StatefulPartitionedCall2L
$BatchNorm-D1/StatefulPartitionedCall$BatchNorm-D1/StatefulPartitionedCall2>
FC-D1/StatefulPartitionedCallFC-D1/StatefulPartitionedCall2@
Logits/StatefulPartitionedCallLogits/StatefulPartitionedCall2D
 Pre_Conv/StatefulPartitionedCall Pre_Conv/StatefulPartitionedCall2R
'T1_CF_BatchNorm/StatefulPartitionedCall'T1_CF_BatchNorm/StatefulPartitionedCall2L
$T1_CF_Conv2D/StatefulPartitionedCall$T1_CF_Conv2D/StatefulPartitionedCall2N
%T1_CF_Dropout/StatefulPartitionedCall%T1_CF_Dropout/StatefulPartitionedCall2R
'T2_CF_BatchNorm/StatefulPartitionedCall'T2_CF_BatchNorm/StatefulPartitionedCall2L
$T2_CF_Conv2D/StatefulPartitionedCall$T2_CF_Conv2D/StatefulPartitionedCall2N
%T2_CF_Dropout/StatefulPartitionedCall%T2_CF_Dropout/StatefulPartitionedCall2R
'T3_CF_BatchNorm/StatefulPartitionedCall'T3_CF_BatchNorm/StatefulPartitionedCall2L
$T3_CF_Conv2D/StatefulPartitionedCall$T3_CF_Conv2D/StatefulPartitionedCall2N
%T3_CF_Dropout/StatefulPartitionedCall%T3_CF_Dropout/StatefulPartitionedCall2Z
+batch_normalization/StatefulPartitionedCall+batch_normalization/StatefulPartitionedCall:T P
+
_output_shapes
:���������-C
!
_user_specified_name	input_1: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
:: 

_output_shapes
: :  

_output_shapes
: : %

_output_shapes
:: *

_output_shapes
:(: /

_output_shapes
:(: 4

_output_shapes
:,
�
f
-__inference_B3_CF1_Dropout_layer_call_fn_7477

inputs
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *Q
fLRJ
H__inference_B3_CF1_Dropout_layer_call_and_return_conditional_losses_3850w
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*/
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������22
StatefulPartitionedCallStatefulPartitionedCall:W S
/
_output_shapes
:���������
 
_user_specified_nameinputs
�
F
*__inference_B4_CF1_ReLu_layer_call_fn_7996

inputs
identity�
PartitionedCallPartitionedCallinputs*
Tin
2*
Tout
2*
_collective_manager_ids
 */
_output_shapes
:���������(* 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8� *N
fIRG
E__inference_B4_CF1_ReLu_layer_call_and_return_conditional_losses_3268h
IdentityIdentityPartitionedCall:output:0*
T0*/
_output_shapes
:���������("
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������(:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs
�
�
F__inference_T3_CF_Conv2D_layer_call_and_return_conditional_losses_7824

inputs8
conv2d_readvariableop_resource:((
identity��Conv2D/ReadVariableOp|
Conv2D/ReadVariableOpReadVariableOpconv2d_readvariableop_resource*&
_output_shapes
:((*
dtype0�
Conv2DConv2DinputsConv2D/ReadVariableOp:value:0*
T0*/
_output_shapes
:���������(*
paddingVALID*
strides
f
IdentityIdentityConv2D:output:0^NoOp*
T0*/
_output_shapes
:���������(^
NoOpNoOp^Conv2D/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*0
_input_shapes
:���������(: 2.
Conv2D/ReadVariableOpConv2D/ReadVariableOp:W S
/
_output_shapes
:���������(
 
_user_specified_nameinputs
�	
�
.__inference_T3_CF_BatchNorm_layer_call_fn_7693

inputs
unknown
	unknown_0:(
	unknown_1:(
	unknown_2:(
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2*
Tin	
2*
Tout
2*
_collective_manager_ids
 *A
_output_shapes/
-:+���������������������������(*%
_read_only_resource_inputs
*-
config_proto

CPU

GPU 2J 8� *R
fMRK
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_2446�
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*A
_output_shapes/
-:+���������������������������(`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*L
_input_shapes;
9:+���������������������������(:(: : : 22
StatefulPartitionedCallStatefulPartitionedCall:i e
A
_output_shapes/
-:+���������������������������(
 
_user_specified_nameinputs: 

_output_shapes
:("�L
saver_filename:0StatefulPartitionedCall_2:0StatefulPartitionedCall_38"
saved_model_main_op

NoOp*>
__saved_model_init_op%#
__saved_model_init_op

NoOp*�
basic�
3
inputs)
basic_inputs:0���������-C:
scores0
StatefulPartitionedCall:0���������tensorflow/serving/predict*�
with_transformation�
>
inputs4
with_transformation_inputs:0����������<
scores2
StatefulPartitionedCall_1:0���������tensorflow/serving/predict:��
_
	model

signatures

�basic
�with_transformation"
_generic_user_object
�
layer-0
layer-1
layer-2
layer_with_weights-0
layer-3
layer_with_weights-1
layer-4
layer-5
	layer_with_weights-2
	layer-6

layer-7
layer_with_weights-3
layer-8
layer-9
layer_with_weights-4
layer-10
layer-11
layer-12
layer_with_weights-5
layer-13
layer-14
layer_with_weights-6
layer-15
layer-16
layer-17
layer-18
layer_with_weights-7
layer-19
layer-20
layer_with_weights-8
layer-21
layer-22
layer_with_weights-9
layer-23
layer-24
layer_with_weights-10
layer-25
layer-26
layer-27
layer_with_weights-11
layer-28
 layer-29
!layer_with_weights-12
!layer-30
"layer-31
#layer-32
$layer-33
%layer_with_weights-13
%layer-34
&layer-35
'layer_with_weights-14
'layer-36
(layer-37
)layer_with_weights-15
)layer-38
*layer-39
+layer_with_weights-16
+layer-40
,layer-41
-layer-42
.layer_with_weights-17
.layer-43
/layer-44
0layer_with_weights-18
0layer-45
1layer-46
2layer-47
3layer-48
4layer_with_weights-19
4layer-49
5layer-50
6layer_with_weights-20
6layer-51
7layer-52
8layer-53
9layer_with_weights-21
9layer-54
:layer-55
;layer-56
<layer_with_weights-22
<layer-57
=layer_with_weights-23
=layer-58
>layer_with_weights-24
>layer-59
?	variables
@trainable_variables
Aregularization_losses
B	keras_api
�__call__
+�&call_and_return_all_conditional_losses
�_default_save_signature"
_tf_keras_network
=

�basic
�with_transformation"
signature_map
"
_tf_keras_input_layer
(
C	keras_api"
_tf_keras_layer
�
D	variables
Etrainable_variables
Fregularization_losses
G	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�

Hkernel
I	variables
Jtrainable_variables
Kregularization_losses
L	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
Maxis
Nbeta
Omoving_mean
Pmoving_variance
Q	variables
Rtrainable_variables
Sregularization_losses
T	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
U	variables
Vtrainable_variables
Wregularization_losses
X	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�

Ykernel
Z	variables
[trainable_variables
\regularization_losses
]	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
^	variables
_trainable_variables
`regularization_losses
a	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
baxis
cbeta
dmoving_mean
emoving_variance
f	variables
gtrainable_variables
hregularization_losses
i	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
j	variables
ktrainable_variables
lregularization_losses
m	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�

nkernel
o	variables
ptrainable_variables
qregularization_losses
r	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
s	variables
ttrainable_variables
uregularization_losses
v	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
w	variables
xtrainable_variables
yregularization_losses
z	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
{axis
|beta
}moving_mean
~moving_variance
	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�kernel
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
)
�	keras_api"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
	�axis
	�beta
�moving_mean
�moving_variance
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�kernel
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
	�axis
	�beta
�moving_mean
�moving_variance
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�kernel
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
	�axis
	�beta
�moving_mean
�moving_variance
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�kernel
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
)
�	keras_api"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
	�axis
	�beta
�moving_mean
�moving_variance
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�kernel
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
	�axis
	�beta
�moving_mean
�moving_variance
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�kernel
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
	�axis
	�beta
�moving_mean
�moving_variance
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�kernel
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
)
�	keras_api"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
	�axis
	�beta
�moving_mean
�moving_variance
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�kernel
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
	�axis
	�beta
�moving_mean
�moving_variance
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�kernel
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
	�axis
	�beta
�moving_mean
�moving_variance
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
�kernel
	�bias
�	variables
�trainable_variables
�regularization_losses
�	keras_api
�__call__
+�&call_and_return_all_conditional_losses"
_tf_keras_layer
�
H0
N1
O2
P3
Y4
c5
d6
e7
n8
|9
}10
~11
�12
�13
�14
�15
�16
�17
�18
�19
�20
�21
�22
�23
�24
�25
�26
�27
�28
�29
�30
�31
�32
�33
�34
�35
�36
�37
�38
�39
�40
�41
�42
�43
�44
�45
�46
�47
�48
�49"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
?	variables
@trainable_variables
Aregularization_losses
�__call__
�_default_save_signature
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
D	variables
Etrainable_variables
Fregularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
):'2Pre_Conv/kernel
'
H0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
I	variables
Jtrainable_variables
Kregularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
#:!2B1_CF1_BatchNorm/beta
,:* (2B1_CF1_BatchNorm/moving_mean
0:. (2 B1_CF1_BatchNorm/moving_variance
5
N0
O1
P2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
Q	variables
Rtrainable_variables
Sregularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
U	variables
Vtrainable_variables
Wregularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
.:,2B1_CF1_Conv2D/kernel
'
Y0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
Z	variables
[trainable_variables
\regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
^	variables
_trainable_variables
`regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
#:!2B1_CF2_BatchNorm/beta
,:* (2B1_CF2_BatchNorm/moving_mean
0:. (2 B1_CF2_BatchNorm/moving_variance
5
c0
d1
e2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
f	variables
gtrainable_variables
hregularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
j	variables
ktrainable_variables
lregularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
.:,2B1_CF2_Conv2D/kernel
'
n0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
o	variables
ptrainable_variables
qregularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
s	variables
ttrainable_variables
uregularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
w	variables
xtrainable_variables
yregularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
": 2T1_CF_BatchNorm/beta
+:) (2T1_CF_BatchNorm/moving_mean
/:- (2T1_CF_BatchNorm/moving_variance
5
|0
}1
~2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
-:+2T1_CF_Conv2D/kernel
(
�0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
#:!2B2_CF1_BatchNorm/beta
,:* (2B2_CF1_BatchNorm/moving_mean
0:. (2 B2_CF1_BatchNorm/moving_variance
8
�0
�1
�2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
.:,2B2_CF1_Conv2D/kernel
(
�0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
#:!2B2_CF2_BatchNorm/beta
,:* (2B2_CF2_BatchNorm/moving_mean
0:. (2 B2_CF2_BatchNorm/moving_variance
8
�0
�1
�2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
.:,2B2_CF2_Conv2D/kernel
(
�0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
":  2T2_CF_BatchNorm/beta
+:)  (2T2_CF_BatchNorm/moving_mean
/:-  (2T2_CF_BatchNorm/moving_variance
8
�0
�1
�2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
-:+  2T2_CF_Conv2D/kernel
(
�0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
#:! 2B3_CF1_BatchNorm/beta
,:*  (2B3_CF1_BatchNorm/moving_mean
0:.  (2 B3_CF1_BatchNorm/moving_variance
8
�0
�1
�2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
.:, 2B3_CF1_Conv2D/kernel
(
�0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
#:!2B3_CF2_BatchNorm/beta
,:* (2B3_CF2_BatchNorm/moving_mean
0:. (2 B3_CF2_BatchNorm/moving_variance
8
�0
�1
�2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
.:,2B3_CF2_Conv2D/kernel
(
�0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
": (2T3_CF_BatchNorm/beta
+:)( (2T3_CF_BatchNorm/moving_mean
/:-( (2T3_CF_BatchNorm/moving_variance
8
�0
�1
�2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
-:+((2T3_CF_Conv2D/kernel
(
�0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
#:!(2B4_CF1_BatchNorm/beta
,:*( (2B4_CF1_BatchNorm/moving_mean
0:.( (2 B4_CF1_BatchNorm/moving_variance
8
�0
�1
�2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
.:,(2B4_CF1_Conv2D/kernel
(
�0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
&:$,2batch_normalization/beta
/:-, (2batch_normalization/moving_mean
3:1, (2#batch_normalization/moving_variance
8
�0
�1
�2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
:,2FC-D1/kernel
(
�0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
 "
trackable_list_wrapper
:2BatchNorm-D1/beta
(:& (2BatchNorm-D1/moving_mean
,:* (2BatchNorm-D1/moving_variance
8
�0
�1
�2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
:2Logits/kernel
:2Logits/bias
0
�0
�1"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
�
�non_trainable_variables
�layers
�metrics
 �layer_regularization_losses
�layer_metrics
�	variables
�trainable_variables
�regularization_losses
�__call__
+�&call_and_return_all_conditional_losses
'�"call_and_return_conditional_losses"
_generic_user_object
�
H0
N1
O2
P3
Y4
c5
d6
e7
n8
|9
}10
~11
�12
�13
�14
�15
�16
�17
�18
�19
�20
�21
�22
�23
�24
�25
�26
�27
�28
�29
�30
�31
�32
�33
�34
�35
�36
�37
�38
�39
�40
�41
�42
�43
�44
�45
�46
�47
�48
�49"
trackable_list_wrapper
�
0
1
2
3
4
5
	6

7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
 29
!30
"31
#32
$33
%34
&35
'36
(37
)38
*39
+40
,41
-42
.43
/44
045
146
247
348
449
550
651
752
853
954
:55
;56
<57
=58
>59"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
'
H0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
5
N0
O1
P2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
'
Y0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
5
c0
d1
e2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
'
n0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
5
|0
}1
~2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
(
�0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
8
�0
�1
�2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
(
�0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
8
�0
�1
�2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
(
�0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
8
�0
�1
�2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
(
�0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
8
�0
�1
�2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
(
�0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
8
�0
�1
�2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
(
�0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
8
�0
�1
�2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
(
�0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
8
�0
�1
�2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
(
�0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
8
�0
�1
�2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
(
�0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
8
�0
�1
�2"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
0
�0
�1"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
�2�
__inference_basic_1004�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *!�
����������-C
�2�
$__inference_with_transformation_1526�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *�
�����������
�2�
'__inference_DenseNet_layer_call_fn_3498
'__inference_DenseNet_layer_call_fn_5505
'__inference_DenseNet_layer_call_fn_5632
'__inference_DenseNet_layer_call_fn_5000�
���
FullArgSpec1
args)�&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults�
p 

 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
B__inference_DenseNet_layer_call_and_return_conditional_losses_5881
B__inference_DenseNet_layer_call_and_return_conditional_losses_6200
B__inference_DenseNet_layer_call_and_return_conditional_losses_5189
B__inference_DenseNet_layer_call_and_return_conditional_losses_5378�
���
FullArgSpec1
args)�&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults�
p 

 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�B�
__inference__wrapped_model_1905input_1"�
���
FullArgSpec
args� 
varargsjargs
varkwjkwargs
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�B�
"__inference_signature_wrapper_1133inputs"�
���
FullArgSpec
args� 
varargs
 
varkwjkwargs
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�B�
"__inference_signature_wrapper_1655inputs"�
���
FullArgSpec
args� 
varargs
 
varkwjkwargs
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
(__inference_rescaling_layer_call_fn_6205�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
C__inference_rescaling_layer_call_and_return_conditional_losses_6213�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
'__inference_Pre_Conv_layer_call_fn_6220�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
B__inference_Pre_Conv_layer_call_and_return_conditional_losses_6227�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
/__inference_B1_CF1_BatchNorm_layer_call_fn_6240
/__inference_B1_CF1_BatchNorm_layer_call_fn_6253
/__inference_B1_CF1_BatchNorm_layer_call_fn_6266
/__inference_B1_CF1_BatchNorm_layer_call_fn_6279�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_6296
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_6313
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_6330
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_6347�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
*__inference_B1_CF1_ReLu_layer_call_fn_6352�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
E__inference_B1_CF1_ReLu_layer_call_and_return_conditional_losses_6357�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
,__inference_B1_CF1_Conv2D_layer_call_fn_6364�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
G__inference_B1_CF1_Conv2D_layer_call_and_return_conditional_losses_6371�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
-__inference_B1_CF1_Dropout_layer_call_fn_6376
-__inference_B1_CF1_Dropout_layer_call_fn_6381�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
H__inference_B1_CF1_Dropout_layer_call_and_return_conditional_losses_6386
H__inference_B1_CF1_Dropout_layer_call_and_return_conditional_losses_6398�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
/__inference_B1_CF2_BatchNorm_layer_call_fn_6411
/__inference_B1_CF2_BatchNorm_layer_call_fn_6424
/__inference_B1_CF2_BatchNorm_layer_call_fn_6437
/__inference_B1_CF2_BatchNorm_layer_call_fn_6450�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_6467
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_6484
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_6501
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_6518�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
*__inference_B1_CF2_ReLu_layer_call_fn_6523�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
E__inference_B1_CF2_ReLu_layer_call_and_return_conditional_losses_6528�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
,__inference_B1_CF2_Conv2D_layer_call_fn_6535�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
G__inference_B1_CF2_Conv2D_layer_call_and_return_conditional_losses_6542�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
-__inference_B1_CF2_Dropout_layer_call_fn_6547
-__inference_B1_CF2_Dropout_layer_call_fn_6552�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
H__inference_B1_CF2_Dropout_layer_call_and_return_conditional_losses_6557
H__inference_B1_CF2_Dropout_layer_call_and_return_conditional_losses_6569�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
(__inference_B1_Concat_layer_call_fn_6576�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
C__inference_B1_Concat_layer_call_and_return_conditional_losses_6584�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
.__inference_T1_CF_BatchNorm_layer_call_fn_6597
.__inference_T1_CF_BatchNorm_layer_call_fn_6610
.__inference_T1_CF_BatchNorm_layer_call_fn_6623
.__inference_T1_CF_BatchNorm_layer_call_fn_6636�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_6653
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_6670
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_6687
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_6704�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
)__inference_T1_CF_ReLu_layer_call_fn_6709�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
D__inference_T1_CF_ReLu_layer_call_and_return_conditional_losses_6714�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
+__inference_T1_CF_Conv2D_layer_call_fn_6721�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
F__inference_T1_CF_Conv2D_layer_call_and_return_conditional_losses_6728�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
,__inference_T1_CF_Dropout_layer_call_fn_6733
,__inference_T1_CF_Dropout_layer_call_fn_6738�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
G__inference_T1_CF_Dropout_layer_call_and_return_conditional_losses_6743
G__inference_T1_CF_Dropout_layer_call_and_return_conditional_losses_6755�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
&__inference_T1_Pool_layer_call_fn_6760
&__inference_T1_Pool_layer_call_fn_6765�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
A__inference_T1_Pool_layer_call_and_return_conditional_losses_6770
A__inference_T1_Pool_layer_call_and_return_conditional_losses_6775�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
/__inference_B2_CF1_BatchNorm_layer_call_fn_6788
/__inference_B2_CF1_BatchNorm_layer_call_fn_6801
/__inference_B2_CF1_BatchNorm_layer_call_fn_6814
/__inference_B2_CF1_BatchNorm_layer_call_fn_6827�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_6844
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_6861
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_6878
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_6895�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
*__inference_B2_CF1_ReLu_layer_call_fn_6900�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
E__inference_B2_CF1_ReLu_layer_call_and_return_conditional_losses_6905�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
,__inference_B2_CF1_Conv2D_layer_call_fn_6912�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
G__inference_B2_CF1_Conv2D_layer_call_and_return_conditional_losses_6919�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
-__inference_B2_CF1_Dropout_layer_call_fn_6924
-__inference_B2_CF1_Dropout_layer_call_fn_6929�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
H__inference_B2_CF1_Dropout_layer_call_and_return_conditional_losses_6934
H__inference_B2_CF1_Dropout_layer_call_and_return_conditional_losses_6946�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
/__inference_B2_CF2_BatchNorm_layer_call_fn_6959
/__inference_B2_CF2_BatchNorm_layer_call_fn_6972
/__inference_B2_CF2_BatchNorm_layer_call_fn_6985
/__inference_B2_CF2_BatchNorm_layer_call_fn_6998�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_7015
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_7032
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_7049
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_7066�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
*__inference_B2_CF2_ReLu_layer_call_fn_7071�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
E__inference_B2_CF2_ReLu_layer_call_and_return_conditional_losses_7076�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
,__inference_B2_CF2_Conv2D_layer_call_fn_7083�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
G__inference_B2_CF2_Conv2D_layer_call_and_return_conditional_losses_7090�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
-__inference_B2_CF2_Dropout_layer_call_fn_7095
-__inference_B2_CF2_Dropout_layer_call_fn_7100�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
H__inference_B2_CF2_Dropout_layer_call_and_return_conditional_losses_7105
H__inference_B2_CF2_Dropout_layer_call_and_return_conditional_losses_7117�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
(__inference_B2_Concat_layer_call_fn_7124�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
C__inference_B2_Concat_layer_call_and_return_conditional_losses_7132�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
.__inference_T2_CF_BatchNorm_layer_call_fn_7145
.__inference_T2_CF_BatchNorm_layer_call_fn_7158
.__inference_T2_CF_BatchNorm_layer_call_fn_7171
.__inference_T2_CF_BatchNorm_layer_call_fn_7184�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_7201
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_7218
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_7235
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_7252�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
)__inference_T2_CF_ReLu_layer_call_fn_7257�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
D__inference_T2_CF_ReLu_layer_call_and_return_conditional_losses_7262�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
+__inference_T2_CF_Conv2D_layer_call_fn_7269�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
F__inference_T2_CF_Conv2D_layer_call_and_return_conditional_losses_7276�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
,__inference_T2_CF_Dropout_layer_call_fn_7281
,__inference_T2_CF_Dropout_layer_call_fn_7286�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
G__inference_T2_CF_Dropout_layer_call_and_return_conditional_losses_7291
G__inference_T2_CF_Dropout_layer_call_and_return_conditional_losses_7303�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
&__inference_T2_Pool_layer_call_fn_7308
&__inference_T2_Pool_layer_call_fn_7313�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
A__inference_T2_Pool_layer_call_and_return_conditional_losses_7318
A__inference_T2_Pool_layer_call_and_return_conditional_losses_7323�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
/__inference_B3_CF1_BatchNorm_layer_call_fn_7336
/__inference_B3_CF1_BatchNorm_layer_call_fn_7349
/__inference_B3_CF1_BatchNorm_layer_call_fn_7362
/__inference_B3_CF1_BatchNorm_layer_call_fn_7375�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_7392
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_7409
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_7426
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_7443�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
*__inference_B3_CF1_ReLu_layer_call_fn_7448�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
E__inference_B3_CF1_ReLu_layer_call_and_return_conditional_losses_7453�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
,__inference_B3_CF1_Conv2D_layer_call_fn_7460�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
G__inference_B3_CF1_Conv2D_layer_call_and_return_conditional_losses_7467�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
-__inference_B3_CF1_Dropout_layer_call_fn_7472
-__inference_B3_CF1_Dropout_layer_call_fn_7477�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
H__inference_B3_CF1_Dropout_layer_call_and_return_conditional_losses_7482
H__inference_B3_CF1_Dropout_layer_call_and_return_conditional_losses_7494�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
/__inference_B3_CF2_BatchNorm_layer_call_fn_7507
/__inference_B3_CF2_BatchNorm_layer_call_fn_7520
/__inference_B3_CF2_BatchNorm_layer_call_fn_7533
/__inference_B3_CF2_BatchNorm_layer_call_fn_7546�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_7563
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_7580
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_7597
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_7614�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
*__inference_B3_CF2_ReLu_layer_call_fn_7619�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
E__inference_B3_CF2_ReLu_layer_call_and_return_conditional_losses_7624�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
,__inference_B3_CF2_Conv2D_layer_call_fn_7631�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
G__inference_B3_CF2_Conv2D_layer_call_and_return_conditional_losses_7638�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
-__inference_B3_CF2_Dropout_layer_call_fn_7643
-__inference_B3_CF2_Dropout_layer_call_fn_7648�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
H__inference_B3_CF2_Dropout_layer_call_and_return_conditional_losses_7653
H__inference_B3_CF2_Dropout_layer_call_and_return_conditional_losses_7665�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
(__inference_B3_Concat_layer_call_fn_7672�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
C__inference_B3_Concat_layer_call_and_return_conditional_losses_7680�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
.__inference_T3_CF_BatchNorm_layer_call_fn_7693
.__inference_T3_CF_BatchNorm_layer_call_fn_7706
.__inference_T3_CF_BatchNorm_layer_call_fn_7719
.__inference_T3_CF_BatchNorm_layer_call_fn_7732�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_7749
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_7766
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_7783
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_7800�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
)__inference_T3_CF_ReLu_layer_call_fn_7805�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
D__inference_T3_CF_ReLu_layer_call_and_return_conditional_losses_7810�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
+__inference_T3_CF_Conv2D_layer_call_fn_7817�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
F__inference_T3_CF_Conv2D_layer_call_and_return_conditional_losses_7824�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
,__inference_T3_CF_Dropout_layer_call_fn_7829
,__inference_T3_CF_Dropout_layer_call_fn_7834�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
G__inference_T3_CF_Dropout_layer_call_and_return_conditional_losses_7839
G__inference_T3_CF_Dropout_layer_call_and_return_conditional_losses_7851�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
&__inference_T3_Pool_layer_call_fn_7856
&__inference_T3_Pool_layer_call_fn_7861�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
A__inference_T3_Pool_layer_call_and_return_conditional_losses_7866
A__inference_T3_Pool_layer_call_and_return_conditional_losses_7871�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
/__inference_B4_CF1_BatchNorm_layer_call_fn_7884
/__inference_B4_CF1_BatchNorm_layer_call_fn_7897
/__inference_B4_CF1_BatchNorm_layer_call_fn_7910
/__inference_B4_CF1_BatchNorm_layer_call_fn_7923�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_7940
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_7957
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_7974
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_7991�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
*__inference_B4_CF1_ReLu_layer_call_fn_7996�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
E__inference_B4_CF1_ReLu_layer_call_and_return_conditional_losses_8001�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
,__inference_B4_CF1_Conv2D_layer_call_fn_8008�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
G__inference_B4_CF1_Conv2D_layer_call_and_return_conditional_losses_8015�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
-__inference_B4_CF1_Dropout_layer_call_fn_8020
-__inference_B4_CF1_Dropout_layer_call_fn_8025�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
H__inference_B4_CF1_Dropout_layer_call_and_return_conditional_losses_8030
H__inference_B4_CF1_Dropout_layer_call_and_return_conditional_losses_8042�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
(__inference_B4_Concat_layer_call_fn_8048�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
C__inference_B4_Concat_layer_call_and_return_conditional_losses_8055�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
2__inference_batch_normalization_layer_call_fn_8068
2__inference_batch_normalization_layer_call_fn_8081
2__inference_batch_normalization_layer_call_fn_8094
2__inference_batch_normalization_layer_call_fn_8107�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
M__inference_batch_normalization_layer_call_and_return_conditional_losses_8124
M__inference_batch_normalization_layer_call_and_return_conditional_losses_8141
M__inference_batch_normalization_layer_call_and_return_conditional_losses_8158
M__inference_batch_normalization_layer_call_and_return_conditional_losses_8175�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
#__inference_ReLu_layer_call_fn_8180�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
>__inference_ReLu_layer_call_and_return_conditional_losses_8185�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
7__inference_global_average_pooling2d_layer_call_fn_8190
7__inference_global_average_pooling2d_layer_call_fn_8195�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
R__inference_global_average_pooling2d_layer_call_and_return_conditional_losses_8201
R__inference_global_average_pooling2d_layer_call_and_return_conditional_losses_8207�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
$__inference_FC-D1_layer_call_fn_8214�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
?__inference_FC-D1_layer_call_and_return_conditional_losses_8221�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
+__inference_BatchNorm-D1_layer_call_fn_8232
+__inference_BatchNorm-D1_layer_call_fn_8243�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
F__inference_BatchNorm-D1_layer_call_and_return_conditional_losses_8260
F__inference_BatchNorm-D1_layer_call_and_return_conditional_losses_8277�
���
FullArgSpec)
args!�
jself
jinputs

jtraining
varargs
 
varkw
 
defaults�
p 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
%__inference_Logits_layer_call_fn_8286�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
@__inference_Logits_layer_call_and_return_conditional_losses_8297�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
	J
Const
J	
Const_1
J	
Const_2
J	
Const_3
J	
Const_4
J	
Const_5
J	
Const_6
J	
Const_7
J	
Const_8
J	
Const_9
J

Const_10�
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_6296��NOPM�J
C�@
:�7
inputs+���������������������������
p 
� "?�<
5�2
0+���������������������������
� �
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_6313��NOPM�J
C�@
:�7
inputs+���������������������������
p
� "?�<
5�2
0+���������������������������
� �
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_6330s�NOP;�8
1�.
(�%
inputs���������-C
p 
� "-�*
#� 
0���������-C
� �
J__inference_B1_CF1_BatchNorm_layer_call_and_return_conditional_losses_6347s�NOP;�8
1�.
(�%
inputs���������-C
p
� "-�*
#� 
0���������-C
� �
/__inference_B1_CF1_BatchNorm_layer_call_fn_6240��NOPM�J
C�@
:�7
inputs+���������������������������
p 
� "2�/+����������������������������
/__inference_B1_CF1_BatchNorm_layer_call_fn_6253��NOPM�J
C�@
:�7
inputs+���������������������������
p
� "2�/+����������������������������
/__inference_B1_CF1_BatchNorm_layer_call_fn_6266f�NOP;�8
1�.
(�%
inputs���������-C
p 
� " ����������-C�
/__inference_B1_CF1_BatchNorm_layer_call_fn_6279f�NOP;�8
1�.
(�%
inputs���������-C
p
� " ����������-C�
G__inference_B1_CF1_Conv2D_layer_call_and_return_conditional_losses_6371kY7�4
-�*
(�%
inputs���������-C
� "-�*
#� 
0���������-C
� �
,__inference_B1_CF1_Conv2D_layer_call_fn_6364^Y7�4
-�*
(�%
inputs���������-C
� " ����������-C�
H__inference_B1_CF1_Dropout_layer_call_and_return_conditional_losses_6386l;�8
1�.
(�%
inputs���������-C
p 
� "-�*
#� 
0���������-C
� �
H__inference_B1_CF1_Dropout_layer_call_and_return_conditional_losses_6398l;�8
1�.
(�%
inputs���������-C
p
� "-�*
#� 
0���������-C
� �
-__inference_B1_CF1_Dropout_layer_call_fn_6376_;�8
1�.
(�%
inputs���������-C
p 
� " ����������-C�
-__inference_B1_CF1_Dropout_layer_call_fn_6381_;�8
1�.
(�%
inputs���������-C
p
� " ����������-C�
E__inference_B1_CF1_ReLu_layer_call_and_return_conditional_losses_6357h7�4
-�*
(�%
inputs���������-C
� "-�*
#� 
0���������-C
� �
*__inference_B1_CF1_ReLu_layer_call_fn_6352[7�4
-�*
(�%
inputs���������-C
� " ����������-C�
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_6467��cdeM�J
C�@
:�7
inputs+���������������������������
p 
� "?�<
5�2
0+���������������������������
� �
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_6484��cdeM�J
C�@
:�7
inputs+���������������������������
p
� "?�<
5�2
0+���������������������������
� �
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_6501s�cde;�8
1�.
(�%
inputs���������-C
p 
� "-�*
#� 
0���������-C
� �
J__inference_B1_CF2_BatchNorm_layer_call_and_return_conditional_losses_6518s�cde;�8
1�.
(�%
inputs���������-C
p
� "-�*
#� 
0���������-C
� �
/__inference_B1_CF2_BatchNorm_layer_call_fn_6411��cdeM�J
C�@
:�7
inputs+���������������������������
p 
� "2�/+����������������������������
/__inference_B1_CF2_BatchNorm_layer_call_fn_6424��cdeM�J
C�@
:�7
inputs+���������������������������
p
� "2�/+����������������������������
/__inference_B1_CF2_BatchNorm_layer_call_fn_6437f�cde;�8
1�.
(�%
inputs���������-C
p 
� " ����������-C�
/__inference_B1_CF2_BatchNorm_layer_call_fn_6450f�cde;�8
1�.
(�%
inputs���������-C
p
� " ����������-C�
G__inference_B1_CF2_Conv2D_layer_call_and_return_conditional_losses_6542kn7�4
-�*
(�%
inputs���������-C
� "-�*
#� 
0���������-C
� �
,__inference_B1_CF2_Conv2D_layer_call_fn_6535^n7�4
-�*
(�%
inputs���������-C
� " ����������-C�
H__inference_B1_CF2_Dropout_layer_call_and_return_conditional_losses_6557l;�8
1�.
(�%
inputs���������-C
p 
� "-�*
#� 
0���������-C
� �
H__inference_B1_CF2_Dropout_layer_call_and_return_conditional_losses_6569l;�8
1�.
(�%
inputs���������-C
p
� "-�*
#� 
0���������-C
� �
-__inference_B1_CF2_Dropout_layer_call_fn_6547_;�8
1�.
(�%
inputs���������-C
p 
� " ����������-C�
-__inference_B1_CF2_Dropout_layer_call_fn_6552_;�8
1�.
(�%
inputs���������-C
p
� " ����������-C�
E__inference_B1_CF2_ReLu_layer_call_and_return_conditional_losses_6528h7�4
-�*
(�%
inputs���������-C
� "-�*
#� 
0���������-C
� �
*__inference_B1_CF2_ReLu_layer_call_fn_6523[7�4
-�*
(�%
inputs���������-C
� " ����������-C�
C__inference_B1_Concat_layer_call_and_return_conditional_losses_6584����
���
���
*�'
inputs/0���������-C
*�'
inputs/1���������-C
*�'
inputs/2���������-C
� "-�*
#� 
0���������-C
� �
(__inference_B1_Concat_layer_call_fn_6576����
���
���
*�'
inputs/0���������-C
*�'
inputs/1���������-C
*�'
inputs/2���������-C
� " ����������-C�
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_6844�����M�J
C�@
:�7
inputs+���������������������������
p 
� "?�<
5�2
0+���������������������������
� �
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_6861�����M�J
C�@
:�7
inputs+���������������������������
p
� "?�<
5�2
0+���������������������������
� �
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_6878v����;�8
1�.
(�%
inputs���������
p 
� "-�*
#� 
0���������
� �
J__inference_B2_CF1_BatchNorm_layer_call_and_return_conditional_losses_6895v����;�8
1�.
(�%
inputs���������
p
� "-�*
#� 
0���������
� �
/__inference_B2_CF1_BatchNorm_layer_call_fn_6788�����M�J
C�@
:�7
inputs+���������������������������
p 
� "2�/+����������������������������
/__inference_B2_CF1_BatchNorm_layer_call_fn_6801�����M�J
C�@
:�7
inputs+���������������������������
p
� "2�/+����������������������������
/__inference_B2_CF1_BatchNorm_layer_call_fn_6814i����;�8
1�.
(�%
inputs���������
p 
� " �����������
/__inference_B2_CF1_BatchNorm_layer_call_fn_6827i����;�8
1�.
(�%
inputs���������
p
� " �����������
G__inference_B2_CF1_Conv2D_layer_call_and_return_conditional_losses_6919l�7�4
-�*
(�%
inputs���������
� "-�*
#� 
0���������
� �
,__inference_B2_CF1_Conv2D_layer_call_fn_6912_�7�4
-�*
(�%
inputs���������
� " �����������
H__inference_B2_CF1_Dropout_layer_call_and_return_conditional_losses_6934l;�8
1�.
(�%
inputs���������
p 
� "-�*
#� 
0���������
� �
H__inference_B2_CF1_Dropout_layer_call_and_return_conditional_losses_6946l;�8
1�.
(�%
inputs���������
p
� "-�*
#� 
0���������
� �
-__inference_B2_CF1_Dropout_layer_call_fn_6924_;�8
1�.
(�%
inputs���������
p 
� " �����������
-__inference_B2_CF1_Dropout_layer_call_fn_6929_;�8
1�.
(�%
inputs���������
p
� " �����������
E__inference_B2_CF1_ReLu_layer_call_and_return_conditional_losses_6905h7�4
-�*
(�%
inputs���������
� "-�*
#� 
0���������
� �
*__inference_B2_CF1_ReLu_layer_call_fn_6900[7�4
-�*
(�%
inputs���������
� " �����������
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_7015�����M�J
C�@
:�7
inputs+���������������������������
p 
� "?�<
5�2
0+���������������������������
� �
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_7032�����M�J
C�@
:�7
inputs+���������������������������
p
� "?�<
5�2
0+���������������������������
� �
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_7049v����;�8
1�.
(�%
inputs���������
p 
� "-�*
#� 
0���������
� �
J__inference_B2_CF2_BatchNorm_layer_call_and_return_conditional_losses_7066v����;�8
1�.
(�%
inputs���������
p
� "-�*
#� 
0���������
� �
/__inference_B2_CF2_BatchNorm_layer_call_fn_6959�����M�J
C�@
:�7
inputs+���������������������������
p 
� "2�/+����������������������������
/__inference_B2_CF2_BatchNorm_layer_call_fn_6972�����M�J
C�@
:�7
inputs+���������������������������
p
� "2�/+����������������������������
/__inference_B2_CF2_BatchNorm_layer_call_fn_6985i����;�8
1�.
(�%
inputs���������
p 
� " �����������
/__inference_B2_CF2_BatchNorm_layer_call_fn_6998i����;�8
1�.
(�%
inputs���������
p
� " �����������
G__inference_B2_CF2_Conv2D_layer_call_and_return_conditional_losses_7090l�7�4
-�*
(�%
inputs���������
� "-�*
#� 
0���������
� �
,__inference_B2_CF2_Conv2D_layer_call_fn_7083_�7�4
-�*
(�%
inputs���������
� " �����������
H__inference_B2_CF2_Dropout_layer_call_and_return_conditional_losses_7105l;�8
1�.
(�%
inputs���������
p 
� "-�*
#� 
0���������
� �
H__inference_B2_CF2_Dropout_layer_call_and_return_conditional_losses_7117l;�8
1�.
(�%
inputs���������
p
� "-�*
#� 
0���������
� �
-__inference_B2_CF2_Dropout_layer_call_fn_7095_;�8
1�.
(�%
inputs���������
p 
� " �����������
-__inference_B2_CF2_Dropout_layer_call_fn_7100_;�8
1�.
(�%
inputs���������
p
� " �����������
E__inference_B2_CF2_ReLu_layer_call_and_return_conditional_losses_7076h7�4
-�*
(�%
inputs���������
� "-�*
#� 
0���������
� �
*__inference_B2_CF2_ReLu_layer_call_fn_7071[7�4
-�*
(�%
inputs���������
� " �����������
C__inference_B2_Concat_layer_call_and_return_conditional_losses_7132����
���
���
*�'
inputs/0���������
*�'
inputs/1���������
*�'
inputs/2���������
� "-�*
#� 
0��������� 
� �
(__inference_B2_Concat_layer_call_fn_7124����
���
���
*�'
inputs/0���������
*�'
inputs/1���������
*�'
inputs/2���������
� " ���������� �
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_7392�����M�J
C�@
:�7
inputs+��������������������������� 
p 
� "?�<
5�2
0+��������������������������� 
� �
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_7409�����M�J
C�@
:�7
inputs+��������������������������� 
p
� "?�<
5�2
0+��������������������������� 
� �
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_7426v����;�8
1�.
(�%
inputs��������� 
p 
� "-�*
#� 
0��������� 
� �
J__inference_B3_CF1_BatchNorm_layer_call_and_return_conditional_losses_7443v����;�8
1�.
(�%
inputs��������� 
p
� "-�*
#� 
0��������� 
� �
/__inference_B3_CF1_BatchNorm_layer_call_fn_7336�����M�J
C�@
:�7
inputs+��������������������������� 
p 
� "2�/+��������������������������� �
/__inference_B3_CF1_BatchNorm_layer_call_fn_7349�����M�J
C�@
:�7
inputs+��������������������������� 
p
� "2�/+��������������������������� �
/__inference_B3_CF1_BatchNorm_layer_call_fn_7362i����;�8
1�.
(�%
inputs��������� 
p 
� " ���������� �
/__inference_B3_CF1_BatchNorm_layer_call_fn_7375i����;�8
1�.
(�%
inputs��������� 
p
� " ���������� �
G__inference_B3_CF1_Conv2D_layer_call_and_return_conditional_losses_7467l�7�4
-�*
(�%
inputs��������� 
� "-�*
#� 
0���������
� �
,__inference_B3_CF1_Conv2D_layer_call_fn_7460_�7�4
-�*
(�%
inputs��������� 
� " �����������
H__inference_B3_CF1_Dropout_layer_call_and_return_conditional_losses_7482l;�8
1�.
(�%
inputs���������
p 
� "-�*
#� 
0���������
� �
H__inference_B3_CF1_Dropout_layer_call_and_return_conditional_losses_7494l;�8
1�.
(�%
inputs���������
p
� "-�*
#� 
0���������
� �
-__inference_B3_CF1_Dropout_layer_call_fn_7472_;�8
1�.
(�%
inputs���������
p 
� " �����������
-__inference_B3_CF1_Dropout_layer_call_fn_7477_;�8
1�.
(�%
inputs���������
p
� " �����������
E__inference_B3_CF1_ReLu_layer_call_and_return_conditional_losses_7453h7�4
-�*
(�%
inputs��������� 
� "-�*
#� 
0��������� 
� �
*__inference_B3_CF1_ReLu_layer_call_fn_7448[7�4
-�*
(�%
inputs��������� 
� " ���������� �
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_7563�����M�J
C�@
:�7
inputs+���������������������������
p 
� "?�<
5�2
0+���������������������������
� �
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_7580�����M�J
C�@
:�7
inputs+���������������������������
p
� "?�<
5�2
0+���������������������������
� �
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_7597v����;�8
1�.
(�%
inputs���������
p 
� "-�*
#� 
0���������
� �
J__inference_B3_CF2_BatchNorm_layer_call_and_return_conditional_losses_7614v����;�8
1�.
(�%
inputs���������
p
� "-�*
#� 
0���������
� �
/__inference_B3_CF2_BatchNorm_layer_call_fn_7507�����M�J
C�@
:�7
inputs+���������������������������
p 
� "2�/+����������������������������
/__inference_B3_CF2_BatchNorm_layer_call_fn_7520�����M�J
C�@
:�7
inputs+���������������������������
p
� "2�/+����������������������������
/__inference_B3_CF2_BatchNorm_layer_call_fn_7533i����;�8
1�.
(�%
inputs���������
p 
� " �����������
/__inference_B3_CF2_BatchNorm_layer_call_fn_7546i����;�8
1�.
(�%
inputs���������
p
� " �����������
G__inference_B3_CF2_Conv2D_layer_call_and_return_conditional_losses_7638l�7�4
-�*
(�%
inputs���������
� "-�*
#� 
0���������
� �
,__inference_B3_CF2_Conv2D_layer_call_fn_7631_�7�4
-�*
(�%
inputs���������
� " �����������
H__inference_B3_CF2_Dropout_layer_call_and_return_conditional_losses_7653l;�8
1�.
(�%
inputs���������
p 
� "-�*
#� 
0���������
� �
H__inference_B3_CF2_Dropout_layer_call_and_return_conditional_losses_7665l;�8
1�.
(�%
inputs���������
p
� "-�*
#� 
0���������
� �
-__inference_B3_CF2_Dropout_layer_call_fn_7643_;�8
1�.
(�%
inputs���������
p 
� " �����������
-__inference_B3_CF2_Dropout_layer_call_fn_7648_;�8
1�.
(�%
inputs���������
p
� " �����������
E__inference_B3_CF2_ReLu_layer_call_and_return_conditional_losses_7624h7�4
-�*
(�%
inputs���������
� "-�*
#� 
0���������
� �
*__inference_B3_CF2_ReLu_layer_call_fn_7619[7�4
-�*
(�%
inputs���������
� " �����������
C__inference_B3_Concat_layer_call_and_return_conditional_losses_7680����
���
���
*�'
inputs/0��������� 
*�'
inputs/1���������
*�'
inputs/2���������
� "-�*
#� 
0���������(
� �
(__inference_B3_Concat_layer_call_fn_7672����
���
���
*�'
inputs/0��������� 
*�'
inputs/1���������
*�'
inputs/2���������
� " ����������(�
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_7940�����M�J
C�@
:�7
inputs+���������������������������(
p 
� "?�<
5�2
0+���������������������������(
� �
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_7957�����M�J
C�@
:�7
inputs+���������������������������(
p
� "?�<
5�2
0+���������������������������(
� �
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_7974v����;�8
1�.
(�%
inputs���������(
p 
� "-�*
#� 
0���������(
� �
J__inference_B4_CF1_BatchNorm_layer_call_and_return_conditional_losses_7991v����;�8
1�.
(�%
inputs���������(
p
� "-�*
#� 
0���������(
� �
/__inference_B4_CF1_BatchNorm_layer_call_fn_7884�����M�J
C�@
:�7
inputs+���������������������������(
p 
� "2�/+���������������������������(�
/__inference_B4_CF1_BatchNorm_layer_call_fn_7897�����M�J
C�@
:�7
inputs+���������������������������(
p
� "2�/+���������������������������(�
/__inference_B4_CF1_BatchNorm_layer_call_fn_7910i����;�8
1�.
(�%
inputs���������(
p 
� " ����������(�
/__inference_B4_CF1_BatchNorm_layer_call_fn_7923i����;�8
1�.
(�%
inputs���������(
p
� " ����������(�
G__inference_B4_CF1_Conv2D_layer_call_and_return_conditional_losses_8015l�7�4
-�*
(�%
inputs���������(
� "-�*
#� 
0���������
� �
,__inference_B4_CF1_Conv2D_layer_call_fn_8008_�7�4
-�*
(�%
inputs���������(
� " �����������
H__inference_B4_CF1_Dropout_layer_call_and_return_conditional_losses_8030l;�8
1�.
(�%
inputs���������
p 
� "-�*
#� 
0���������
� �
H__inference_B4_CF1_Dropout_layer_call_and_return_conditional_losses_8042l;�8
1�.
(�%
inputs���������
p
� "-�*
#� 
0���������
� �
-__inference_B4_CF1_Dropout_layer_call_fn_8020_;�8
1�.
(�%
inputs���������
p 
� " �����������
-__inference_B4_CF1_Dropout_layer_call_fn_8025_;�8
1�.
(�%
inputs���������
p
� " �����������
E__inference_B4_CF1_ReLu_layer_call_and_return_conditional_losses_8001h7�4
-�*
(�%
inputs���������(
� "-�*
#� 
0���������(
� �
*__inference_B4_CF1_ReLu_layer_call_fn_7996[7�4
-�*
(�%
inputs���������(
� " ����������(�
C__inference_B4_Concat_layer_call_and_return_conditional_losses_8055�j�g
`�]
[�X
*�'
inputs/0���������(
*�'
inputs/1���������
� "-�*
#� 
0���������,
� �
(__inference_B4_Concat_layer_call_fn_8048�j�g
`�]
[�X
*�'
inputs/0���������(
*�'
inputs/1���������
� " ����������,�
F__inference_BatchNorm-D1_layer_call_and_return_conditional_losses_8260d���3�0
)�&
 �
inputs���������
p 
� "%�"
�
0���������
� �
F__inference_BatchNorm-D1_layer_call_and_return_conditional_losses_8277d���3�0
)�&
 �
inputs���������
p
� "%�"
�
0���������
� �
+__inference_BatchNorm-D1_layer_call_fn_8232W���3�0
)�&
 �
inputs���������
p 
� "�����������
+__inference_BatchNorm-D1_layer_call_fn_8243W���3�0
)�&
 �
inputs���������
p
� "�����������
B__inference_DenseNet_layer_call_and_return_conditional_losses_5189�nH�NOPY�cden�|}~����������������������������������������������<�9
2�/
%�"
input_1���������-C
p 

 
� "%�"
�
0���������
� �
B__inference_DenseNet_layer_call_and_return_conditional_losses_5378�nH�NOPY�cden�|}~����������������������������������������������<�9
2�/
%�"
input_1���������-C
p

 
� "%�"
�
0���������
� �
B__inference_DenseNet_layer_call_and_return_conditional_losses_5881�nH�NOPY�cden�|}~����������������������������������������������;�8
1�.
$�!
inputs���������-C
p 

 
� "%�"
�
0���������
� �
B__inference_DenseNet_layer_call_and_return_conditional_losses_6200�nH�NOPY�cden�|}~����������������������������������������������;�8
1�.
$�!
inputs���������-C
p

 
� "%�"
�
0���������
� �
'__inference_DenseNet_layer_call_fn_3498�nH�NOPY�cden�|}~����������������������������������������������<�9
2�/
%�"
input_1���������-C
p 

 
� "�����������
'__inference_DenseNet_layer_call_fn_5000�nH�NOPY�cden�|}~����������������������������������������������<�9
2�/
%�"
input_1���������-C
p

 
� "�����������
'__inference_DenseNet_layer_call_fn_5505�nH�NOPY�cden�|}~����������������������������������������������;�8
1�.
$�!
inputs���������-C
p 

 
� "�����������
'__inference_DenseNet_layer_call_fn_5632�nH�NOPY�cden�|}~����������������������������������������������;�8
1�.
$�!
inputs���������-C
p

 
� "�����������
?__inference_FC-D1_layer_call_and_return_conditional_losses_8221\�/�,
%�"
 �
inputs���������,
� "%�"
�
0���������
� w
$__inference_FC-D1_layer_call_fn_8214O�/�,
%�"
 �
inputs���������,
� "�����������
@__inference_Logits_layer_call_and_return_conditional_losses_8297^��/�,
%�"
 �
inputs���������
� "%�"
�
0���������
� z
%__inference_Logits_layer_call_fn_8286Q��/�,
%�"
 �
inputs���������
� "�����������
B__inference_Pre_Conv_layer_call_and_return_conditional_losses_6227kH7�4
-�*
(�%
inputs���������-C
� "-�*
#� 
0���������-C
� �
'__inference_Pre_Conv_layer_call_fn_6220^H7�4
-�*
(�%
inputs���������-C
� " ����������-C�
>__inference_ReLu_layer_call_and_return_conditional_losses_8185h7�4
-�*
(�%
inputs���������,
� "-�*
#� 
0���������,
� �
#__inference_ReLu_layer_call_fn_8180[7�4
-�*
(�%
inputs���������,
� " ����������,�
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_6653��|}~M�J
C�@
:�7
inputs+���������������������������
p 
� "?�<
5�2
0+���������������������������
� �
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_6670��|}~M�J
C�@
:�7
inputs+���������������������������
p
� "?�<
5�2
0+���������������������������
� �
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_6687s�|}~;�8
1�.
(�%
inputs���������-C
p 
� "-�*
#� 
0���������-C
� �
I__inference_T1_CF_BatchNorm_layer_call_and_return_conditional_losses_6704s�|}~;�8
1�.
(�%
inputs���������-C
p
� "-�*
#� 
0���������-C
� �
.__inference_T1_CF_BatchNorm_layer_call_fn_6597��|}~M�J
C�@
:�7
inputs+���������������������������
p 
� "2�/+����������������������������
.__inference_T1_CF_BatchNorm_layer_call_fn_6610��|}~M�J
C�@
:�7
inputs+���������������������������
p
� "2�/+����������������������������
.__inference_T1_CF_BatchNorm_layer_call_fn_6623f�|}~;�8
1�.
(�%
inputs���������-C
p 
� " ����������-C�
.__inference_T1_CF_BatchNorm_layer_call_fn_6636f�|}~;�8
1�.
(�%
inputs���������-C
p
� " ����������-C�
F__inference_T1_CF_Conv2D_layer_call_and_return_conditional_losses_6728l�7�4
-�*
(�%
inputs���������-C
� "-�*
#� 
0���������-C
� �
+__inference_T1_CF_Conv2D_layer_call_fn_6721_�7�4
-�*
(�%
inputs���������-C
� " ����������-C�
G__inference_T1_CF_Dropout_layer_call_and_return_conditional_losses_6743l;�8
1�.
(�%
inputs���������-C
p 
� "-�*
#� 
0���������-C
� �
G__inference_T1_CF_Dropout_layer_call_and_return_conditional_losses_6755l;�8
1�.
(�%
inputs���������-C
p
� "-�*
#� 
0���������-C
� �
,__inference_T1_CF_Dropout_layer_call_fn_6733_;�8
1�.
(�%
inputs���������-C
p 
� " ����������-C�
,__inference_T1_CF_Dropout_layer_call_fn_6738_;�8
1�.
(�%
inputs���������-C
p
� " ����������-C�
D__inference_T1_CF_ReLu_layer_call_and_return_conditional_losses_6714h7�4
-�*
(�%
inputs���������-C
� "-�*
#� 
0���������-C
� �
)__inference_T1_CF_ReLu_layer_call_fn_6709[7�4
-�*
(�%
inputs���������-C
� " ����������-C�
A__inference_T1_Pool_layer_call_and_return_conditional_losses_6770�R�O
H�E
C�@
inputs4������������������������������������
� "H�E
>�;
04������������������������������������
� �
A__inference_T1_Pool_layer_call_and_return_conditional_losses_6775h7�4
-�*
(�%
inputs���������-E
� "-�*
#� 
0���������
� �
&__inference_T1_Pool_layer_call_fn_6760�R�O
H�E
C�@
inputs4������������������������������������
� ";�84�������������������������������������
&__inference_T1_Pool_layer_call_fn_6765[7�4
-�*
(�%
inputs���������-E
� " �����������
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_7201�����M�J
C�@
:�7
inputs+��������������������������� 
p 
� "?�<
5�2
0+��������������������������� 
� �
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_7218�����M�J
C�@
:�7
inputs+��������������������������� 
p
� "?�<
5�2
0+��������������������������� 
� �
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_7235v����;�8
1�.
(�%
inputs��������� 
p 
� "-�*
#� 
0��������� 
� �
I__inference_T2_CF_BatchNorm_layer_call_and_return_conditional_losses_7252v����;�8
1�.
(�%
inputs��������� 
p
� "-�*
#� 
0��������� 
� �
.__inference_T2_CF_BatchNorm_layer_call_fn_7145�����M�J
C�@
:�7
inputs+��������������������������� 
p 
� "2�/+��������������������������� �
.__inference_T2_CF_BatchNorm_layer_call_fn_7158�����M�J
C�@
:�7
inputs+��������������������������� 
p
� "2�/+��������������������������� �
.__inference_T2_CF_BatchNorm_layer_call_fn_7171i����;�8
1�.
(�%
inputs��������� 
p 
� " ���������� �
.__inference_T2_CF_BatchNorm_layer_call_fn_7184i����;�8
1�.
(�%
inputs��������� 
p
� " ���������� �
F__inference_T2_CF_Conv2D_layer_call_and_return_conditional_losses_7276l�7�4
-�*
(�%
inputs��������� 
� "-�*
#� 
0��������� 
� �
+__inference_T2_CF_Conv2D_layer_call_fn_7269_�7�4
-�*
(�%
inputs��������� 
� " ���������� �
G__inference_T2_CF_Dropout_layer_call_and_return_conditional_losses_7291l;�8
1�.
(�%
inputs��������� 
p 
� "-�*
#� 
0��������� 
� �
G__inference_T2_CF_Dropout_layer_call_and_return_conditional_losses_7303l;�8
1�.
(�%
inputs��������� 
p
� "-�*
#� 
0��������� 
� �
,__inference_T2_CF_Dropout_layer_call_fn_7281_;�8
1�.
(�%
inputs��������� 
p 
� " ���������� �
,__inference_T2_CF_Dropout_layer_call_fn_7286_;�8
1�.
(�%
inputs��������� 
p
� " ���������� �
D__inference_T2_CF_ReLu_layer_call_and_return_conditional_losses_7262h7�4
-�*
(�%
inputs��������� 
� "-�*
#� 
0��������� 
� �
)__inference_T2_CF_ReLu_layer_call_fn_7257[7�4
-�*
(�%
inputs��������� 
� " ���������� �
A__inference_T2_Pool_layer_call_and_return_conditional_losses_7318�R�O
H�E
C�@
inputs4������������������������������������
� "H�E
>�;
04������������������������������������
� �
A__inference_T2_Pool_layer_call_and_return_conditional_losses_7323h7�4
-�*
(�%
inputs��������� 
� "-�*
#� 
0��������� 
� �
&__inference_T2_Pool_layer_call_fn_7308�R�O
H�E
C�@
inputs4������������������������������������
� ";�84�������������������������������������
&__inference_T2_Pool_layer_call_fn_7313[7�4
-�*
(�%
inputs��������� 
� " ���������� �
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_7749�����M�J
C�@
:�7
inputs+���������������������������(
p 
� "?�<
5�2
0+���������������������������(
� �
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_7766�����M�J
C�@
:�7
inputs+���������������������������(
p
� "?�<
5�2
0+���������������������������(
� �
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_7783v����;�8
1�.
(�%
inputs���������(
p 
� "-�*
#� 
0���������(
� �
I__inference_T3_CF_BatchNorm_layer_call_and_return_conditional_losses_7800v����;�8
1�.
(�%
inputs���������(
p
� "-�*
#� 
0���������(
� �
.__inference_T3_CF_BatchNorm_layer_call_fn_7693�����M�J
C�@
:�7
inputs+���������������������������(
p 
� "2�/+���������������������������(�
.__inference_T3_CF_BatchNorm_layer_call_fn_7706�����M�J
C�@
:�7
inputs+���������������������������(
p
� "2�/+���������������������������(�
.__inference_T3_CF_BatchNorm_layer_call_fn_7719i����;�8
1�.
(�%
inputs���������(
p 
� " ����������(�
.__inference_T3_CF_BatchNorm_layer_call_fn_7732i����;�8
1�.
(�%
inputs���������(
p
� " ����������(�
F__inference_T3_CF_Conv2D_layer_call_and_return_conditional_losses_7824l�7�4
-�*
(�%
inputs���������(
� "-�*
#� 
0���������(
� �
+__inference_T3_CF_Conv2D_layer_call_fn_7817_�7�4
-�*
(�%
inputs���������(
� " ����������(�
G__inference_T3_CF_Dropout_layer_call_and_return_conditional_losses_7839l;�8
1�.
(�%
inputs���������(
p 
� "-�*
#� 
0���������(
� �
G__inference_T3_CF_Dropout_layer_call_and_return_conditional_losses_7851l;�8
1�.
(�%
inputs���������(
p
� "-�*
#� 
0���������(
� �
,__inference_T3_CF_Dropout_layer_call_fn_7829_;�8
1�.
(�%
inputs���������(
p 
� " ����������(�
,__inference_T3_CF_Dropout_layer_call_fn_7834_;�8
1�.
(�%
inputs���������(
p
� " ����������(�
D__inference_T3_CF_ReLu_layer_call_and_return_conditional_losses_7810h7�4
-�*
(�%
inputs���������(
� "-�*
#� 
0���������(
� �
)__inference_T3_CF_ReLu_layer_call_fn_7805[7�4
-�*
(�%
inputs���������(
� " ����������(�
A__inference_T3_Pool_layer_call_and_return_conditional_losses_7866�R�O
H�E
C�@
inputs4������������������������������������
� "H�E
>�;
04������������������������������������
� �
A__inference_T3_Pool_layer_call_and_return_conditional_losses_7871h7�4
-�*
(�%
inputs���������	(
� "-�*
#� 
0���������(
� �
&__inference_T3_Pool_layer_call_fn_7856�R�O
H�E
C�@
inputs4������������������������������������
� ";�84�������������������������������������
&__inference_T3_Pool_layer_call_fn_7861[7�4
-�*
(�%
inputs���������	(
� " ����������(�
__inference__wrapped_model_1905�nH�NOPY�cden�|}~����������������������������������������������4�1
*�'
%�"
input_1���������-C
� "/�,
*
Logits �
Logits����������
__inference_basic_1004�nH�NOPY�cden�|}~����������������������������������������������3�0
)�&
$�!
inputs���������-C
� "/�,
*
scores �
scores����������
M__inference_batch_normalization_layer_call_and_return_conditional_losses_8124�����M�J
C�@
:�7
inputs+���������������������������,
p 
� "?�<
5�2
0+���������������������������,
� �
M__inference_batch_normalization_layer_call_and_return_conditional_losses_8141�����M�J
C�@
:�7
inputs+���������������������������,
p
� "?�<
5�2
0+���������������������������,
� �
M__inference_batch_normalization_layer_call_and_return_conditional_losses_8158v����;�8
1�.
(�%
inputs���������,
p 
� "-�*
#� 
0���������,
� �
M__inference_batch_normalization_layer_call_and_return_conditional_losses_8175v����;�8
1�.
(�%
inputs���������,
p
� "-�*
#� 
0���������,
� �
2__inference_batch_normalization_layer_call_fn_8068�����M�J
C�@
:�7
inputs+���������������������������,
p 
� "2�/+���������������������������,�
2__inference_batch_normalization_layer_call_fn_8081�����M�J
C�@
:�7
inputs+���������������������������,
p
� "2�/+���������������������������,�
2__inference_batch_normalization_layer_call_fn_8094i����;�8
1�.
(�%
inputs���������,
p 
� " ����������,�
2__inference_batch_normalization_layer_call_fn_8107i����;�8
1�.
(�%
inputs���������,
p
� " ����������,�
R__inference_global_average_pooling2d_layer_call_and_return_conditional_losses_8201�R�O
H�E
C�@
inputs4������������������������������������
� ".�+
$�!
0������������������
� �
R__inference_global_average_pooling2d_layer_call_and_return_conditional_losses_8207`7�4
-�*
(�%
inputs���������,
� "%�"
�
0���������,
� �
7__inference_global_average_pooling2d_layer_call_fn_8190wR�O
H�E
C�@
inputs4������������������������������������
� "!��������������������
7__inference_global_average_pooling2d_layer_call_fn_8195S7�4
-�*
(�%
inputs���������,
� "����������,�
C__inference_rescaling_layer_call_and_return_conditional_losses_6213h7�4
-�*
(�%
inputs���������-C
� "-�*
#� 
0���������-C
� �
(__inference_rescaling_layer_call_fn_6205[7�4
-�*
(�%
inputs���������-C
� " ����������-C�
"__inference_signature_wrapper_1133�nH�NOPY�cden�|}~����������������������������������������������=�:
� 
3�0
.
inputs$�!
inputs���������-C"/�,
*
scores �
scores����������
"__inference_signature_wrapper_1655�nH�NOPY�cden�|}~����������������������������������������������:�7
� 
0�-
+
inputs!�
inputs����������"/�,
*
scores �
scores����������
$__inference_with_transformation_1526�nH�NOPY�cden�|}~����������������������������������������������0�-
&�#
!�
inputs����������
� "/�,
*
scores �
scores���������