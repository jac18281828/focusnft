FROM ghcr.io/collectivexyz/foundry:latest

ARG PROJECT=FocusNFT
WORKDIR /workspaces/${PROJECT}
RUN chown -R mr.mr .
COPY --chown=mr:mr . .
ENV USER=mr
USER mr
ENV PATH=${PATH}:~/.cargo/bin
RUN yarn install
RUN yarn prettier:check
RUN yarn hint
RUN forge test -vvv


