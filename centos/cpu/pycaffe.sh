#此步骤是在安装caffe之后执行的
#caffe的安装路径是~/caffe-master

#主要问题：
#1.centos6.7的python是2.6，caffe需要python2.7
#2.boost需要安装python支持

###############1.anaconda##############
#centos6.7 使用的python2.6，python的一些包需要python2.7，此处存在问题
#故使用anaconda
#本文将anaconda安装到/usr/local/lib/anaconda

#由于系统使用的是python2.6，不要修改/usr/bin/python的软链接和python的lib
#否则会出现一些未知错误，例如登出后无法进入桌面等

#故修改自己的.bashrc添加
#export PATH="/usr/local/lib/anaconda/bin:$PATH"
#export PATH="/usr/local/lib/anaconda/lib:$PATH
#这样自己使用时，python的指向会是anaconda的python2.7.9，也可以使用anaconda的库例如skimage等

anacondapath="/usr/local/lib/anaconda"
boostpath="boost_1_59_0"

if [ ! -d "$anacondapath" ]; then
	sudo sh Anaconda-2.2.0-Linux-x86_64.sh
	#根据提示安装，安装路径设为/usr/local/lib/anaconda
	echo "export PATH=\"/usr/local/lib/anaconda/bin:\$PATH\"">>~/.bashrc
	echo "export PATH=\"/usr/local/lib/anaconda/lib:\$PATH\"">>~/.bashrc
	source ~/.bashrc
fi
	
##############2.boost需要添加python支持#####################
if [ ! -d "$boostpath" ]; then
	tar -jxvf boost_1_59_0.tar.bz2
	cd boost_1_59_0
	sudo ./b2 --with-python install
	cd ..
fi


#python interface
cd ~/caffe-master
sudo yum install -y python-devel python-pip
for req in $(cat python/requirements.txt); do
        sudo pip install $req;
done
make pycaffe