FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 5000

ENV ASPNETCORE_URLS=http://+:5000

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["ConversaoPeso.Web.csproj", "conversao-peso/ConversaoPeso.Web/"]
RUN dir conversao-peso/ConversaoPeso.Web/
RUN dotnet restore "conversao-peso\ConversaoPeso.Web\ConversaoPeso.Web.csproj"
COPY . .
WORKDIR "/src/conversao-peso/ConversaoPeso.Web"
RUN dir /src/conversao-peso/ConversaoPeso.Web
RUN dotnet build "ConversaoPeso.Web.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ConversaoPeso.Web.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ConversaoPeso.Web.dll"]
