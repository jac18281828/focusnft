FROM ghcr.io/collectivexyz/foundry:latest

ARG PROJECT=focusnft
WORKDIR /workspaces/${PROJECT}
RUN chown -R mr.mr .
COPY --chown=mr:mr . .
ENV USER=mr
USER mr
ENV PATH=${PATH}:~/.cargo/bin
RUN yarn install
RUN yarn lint
RUN forge test -vvv


