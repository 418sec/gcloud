FROM mcr.microsoft.com/dotnet/sdk AS build
USER root
WORKDIR /app

COPY *.csproj ./
RUN dotnet restore

# # Install NPM
# ARG ANGULAR_DIRECTORY="bet-angular"
# COPY ./${ANGULAR_DIRECTORY}/package.json ./${ANGULAR_DIRECTORY}/package.json
# RUN curl -sL https://deb.nodesource.com/setup_14.x \
#     | bash - \
#     && apt-get install -y --no-install-recommends nodejs
#     # && cd ${ANGULAR_DIRECTORY} \
#     # && npm install

COPY . .
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 as capsh
RUN apt-get update
RUN apt-get install -y g++
RUN apt-get install make
COPY ./libcap libcap
RUN cd libcap/progs && make

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
COPY one-run.sh /usr/local/bin/one-run.sh
COPY one-run-apply.sh /usr/local/bin/one-run-apply.sh
COPY --from=capsh libcap/progs/capsh /usr/local/sbin/capsh
COPY --from=build /app/out /usr/local/bin/one-run
COPY bet-angular/dist /usr/local/bin/one-run/bet-angular/dist
# Install the dependencies for Visual Studio Remote Debugger
# RUN apt-get update && apt-get install -y --no-install-recommends unzip procps
# # Install Visual Studio Remote Debugger
# RUN curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -v latest -l ~/vsdbg
RUN apt-get update &&  apt-get install sudo -y
RUN adduser -u 1000 --disabled-password --gecos "" oneuser
RUN echo "oneuser ALL=(ALL) NOPASSWD:/usr/local/bin/one-run.sh" >> /etc/sudoers
COPY cert.pfx /home/oneuser/.aspnet/https/cert.pfx
RUN chown -R oneuser /home/oneuser/.aspnet
EXPOSE 443
USER oneuser
ENTRYPOINT bash -c 'sudo /usr/local/bin/one-run.sh'
