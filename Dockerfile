FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY ["HelloProj1/HelloProj1.csproj", "HelloProj1/"]
RUN dotnet restore "HelloProj1/HelloProj1.csproj"
COPY . .
WORKDIR "/src/HelloProj1"
RUN dotnet build "HelloProj1.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "HelloProj1.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "HelloProj1.dll"]