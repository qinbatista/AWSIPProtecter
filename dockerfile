FROM alpine:3.18.2

ARG aws_key
ARG aws_secret

ADD * /
# RUN apt-get clean
# RUN apt-get update
# RUN apt-get -y install python3 unzip python3-pip curl
# RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# RUN unzip awscliv2.zip
# RUN ./aws/install

RUN apk update && apk add aws-cli python3 py3-pip

RUN aws configure set aws_access_key_id ${aws_key}
RUN aws configure set aws_secret_access_key ${aws_secret}
RUN aws configure set default.region us-west-2
RUN aws configure set region us-west-2 --profile testing

ADD requirements.txt /
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
EXPOSE 7171
WORKDIR /root
CMD [ "python3" ,"/aws_lightsail_controller.py"]
