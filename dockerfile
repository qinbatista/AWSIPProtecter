FROM debian
ADD * /
RUN apt-get clean
RUN apt-get update
RUN apt-get -y install python3 unzip python3-pip curl
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
RUN aws configure set aws_access_key_id AKIA4ARPVTO2AUQ3FLNL
RUN aws configure set aws_secret_access_key 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
RUN aws configure set default.region us-west-2
RUN aws configure set region us-west-2 --profile testing

ADD requirements.txt /
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
EXPOSE 7171
WORKDIR /root
CMD [ "python3" ,"/aws_lightsail_controller.py"]