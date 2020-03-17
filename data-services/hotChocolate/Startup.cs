using System;
using CX_Graphql.ActionTypeResolvers;
using CX_Graphql.Data;
using CX_Identity.Models;
using HotChocolate;
using HotChocolate.AspNetCore;
using HotChocolate.AspNetCore.Voyager;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace CX_Graphql
{
    public class Startup
    {
        private readonly IConfiguration _config;
        readonly string origins = "origins";
        public Startup(IConfiguration configuration)
        {
            _config = configuration;
        }      

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {

            services.AddCors(options => {
                options.AddPolicy(origins,
                  b => {
                      b.WithOrigins("http://localhost:3000") // change to approriate client url, or use "*" to leave wide open
                       .AllowAnyHeader() // required for POST
                       .AllowAnyMethod(); // required to allow for any header on preflight
              });
            });

            services
            .AddEntityFrameworkSqlServer()
            .AddDbContext<IdentityContext>(options => options.UseSqlServer(_config.GetConnectionString("IdentityConnection")));

            services
               .AddDataLoaderRegistry()
               .AddGraphQL(sp =>
                    SchemaBuilder.New()
                       .AddServices(sp)
                       .AddQueryType<QueryType>()
                       //.AddMutationType<MutationType>()
                       .AddType<Client>()
                       .Create());
            //services
            //    .AddDbContextPool<IdentityContext>(options => options.UseSqlServer(_config.GetConnectionString("IdentityConnection")))
            //    .addda
            //    .AddGraphQL(sp =>
            //        SchemaBuilder.New()
            //        .AddQueryType<QueryType>()
            //        .Create());
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();                
            }
            app
                .UseCors(origins)
                .UseGraphQLHttpPost(new HttpPostMiddlewareOptions { Path = "/graphql" })
                .UseGraphQLHttpGetSchema(new HttpGetSchemaMiddlewareOptions { Path = "/graphql/schema" })
                .UsePlayground("/graphql")
                .UseVoyager("/graphql");
        }
    }
}
