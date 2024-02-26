FROM ghcr.io/collectivexyz/foundry:latest

ARG PROJECT=FocusNFT
WORKDIR /workspaces/${PROJECT}
RUN chown -R foundry:foundry .
COPY --chown=foundry:foundry . .
ENV USER=foundry
USER foundry
ENV PATH=${PATH}:~/.cargo/bin:/usr/local/go/bin


RUN yamlfmt -lint .github/workflows/*.yml

RUN yarn install --dev
RUN yarn prettier:check
RUN yarn hint
RUN forge test -vvv
