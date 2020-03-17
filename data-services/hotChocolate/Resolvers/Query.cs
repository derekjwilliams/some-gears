using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CX_Graphql.Data;
using CX_Graphql.Models;
using CX_Identity.Models;
using HotChocolate;
using Microsoft.EntityFrameworkCore;

namespace CX_Graphql.Resolvers
{
    public class Query
    {
        public async Task<IReadOnlyList<Client>> GetClients([Service] IdentityContext dbContext) =>
            await dbContext.Clients.Include(c => c.Users).Include(e => e.ClientUIInfo).ToListAsync();

        public async Task<IReadOnlyList<ClientUIInfo>> GetClientUIInfos([Service] IdentityContext dbContext) =>
            await dbContext.ClientUIInfos.Include(e => e.Client).ToListAsync();

        public async Task<IReadOnlyList<User>> GetUsers([Service] IdentityContext dbContext) =>
            await dbContext.Users.Include(c => c.Client).Include(u=> u.UserClaims).ToListAsync();

        public async Task<IReadOnlyList<UserClaims>> GetUserClaims([Service] IdentityContext dbContext) =>
            await dbContext.UserClaims.Include(u => u.Users).ToListAsync();
    }
}
