1��  copyright (c) 1992, ice app ��!x�l�!p�F#�����^� ����n���^#~��[�x/��]����8�+���-���"�@�1���:���G:d�x����2d���2Q	���ƀ��#~�8	�R���S���X���1ں:�9Һ:��y���Vʚ�R�b�S�\�T�h�P�V�U�n�X�z�Mʅ�Qʔ�$ʎ��A��E��=��� ��͍�  �j<2C:� 2���c�
͍1�� ͡
͍ >~͕!� ~��l#O�o6 .�~�a�^�{�^�_w#�P�2�2�2�!� l ̈́�G�=�	�[\ ̈́�G����[�	�[�G�]���Qʾ�P���Vʸ� ��
�[2�Ö2�Ö2�Ö!"�!l D�x�2d2�!\ �OM	�L!D�O\	�L*�"�"�:M	O:\	��>2�!E~� �'6?#� ] !E�?�@��@	�[#�/�Q�2�\ � ����[�����ƀo& "�́��� ���\:���	�[É�Q*�"�*�~�t###��§�o�<�[�	͍:M	O����z*�� �* ������*��͡���~���*�#4��#4*�� "�ù*���+++0 6�	"���ڏ*�"��_�Y:���=�2�2�<2���y�͈		<�[:���V�ͺ*�#^#V�*��*�#~5#G�ʉx��h5*��͡�̓	��[*�� "��V+4:����� ͡!��$�x�͵�"��}���+���~*�� ����#��"�í
�[��t!.	<�[*�~��R�w2�*�$ 	��x��y�ͫ�<�[:\	O!���	͍*��*�0 	"����X�*�����*��*�����gÆ?	͍:���(:���u�	͍͒�  ~#�x�*��w#w#w#�:\ *�#~�#p	p#D
w�*�>#�
�?»~�=°�"��:���*����$ :\	O�=ͦ��###:M	O��	͍͒�:���:��_�Y�"��>�2��y#��A_ͦ:ͦ��8~� ��.ͦ�~#� �G��_ͦ���8� �mM	�m\	�TM	�m\	�b�y�ʋ=��=��*~#�|�|�  N#6�#�Ϳ
 ^#V#�"��^#V�s#r#�*� ~O/_#~G/W�s#r#��m��s#r��~����:Ͱ��j����~
�aͰ��N�`������:��^���#~�6 �+��*�#� ����c
͍���##^#V#N#F#�^#V��:���^ 	��9
͍�͍A
͍�{�A_ͦQ
:���͍͒�*�]T	"��}D�ͦ
æ:C�> �G��(� ʡ�*���.�A�:�A�"�:��x��A�@G> á�"�*���:�A�.���:��>?�:����{�_�"�:�A�.�A�*��:��>?�:���> ��7~#��6�=�6�[�+33���)
�[~#� �G�~6 �p	�[��j�! �)�d� � � � � � � 	� �
� 
� � � � � !� $�  * �� %� � }�|��Sorry, CP/M version 2 required$No Source File$No Directory Space$Out of Data Space$Write Protected?$Copy Complete$�~6 �Source$�j�! Destination$Illegal Device$File Mask$
Load System Disk in Drive A:, then type (cr)$No More Files$Loading $ Created
$ (y/n) ? $"=" Expected$Illegal Separator$
*$Verify: Bad Sector$Illegal Switch$File Spec Error$
Load $ Disk in Drive $:, then Type (cr)$
Wrong Disk, Try Another!$
Load Any Disk in Drive A:, then type (cr)$

        Disk Interchange Program - ver 3.2
           @ copyright ICE APP 1992

Syntax:
    Destination = Source

    DIP d:filespec = d:[options]
    DIP d: = filespec[options]
    DIP d:filespec = d:filespec[options]
    DIP(cr)
    *
Purpose:
    DIP is a disk file transfer program, with a 'querry' feature.
    DIP makes itself usefull in single drive systems,
    where PIP fails due to the 'Drive R/O' error.
DIP options:
    Q   Querry user for each file transfer
    P   Prompt user for each disk change
    V   Read + Compare after Write (Verify)
Example:
    Backup selected files to another disk, with verify
    DIP A:=*.*[qpv]
$he 'Drive R/O' error.
DIP options:
    Q   Querry user for each file transfer
    P   Prompt user f
r each disk change
    V DIP     $$$mpare after Write (Veri                          