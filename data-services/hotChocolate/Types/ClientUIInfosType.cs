using System;
using System.Linq;
using System.Threading.Tasks;
using CX_Graphql.Data;
using CX_Identity.Models;
using HotChocolate;
using HotChocolate.Resolvers;
using HotChocolate.Types;
using Microsoft.EntityFrameworkCore;

namespace CX_Identity.Types
{
    public class ClientUIInfosType : ObjectType<ClientUIInfo>
    {
        protected override void Configure(IObjectTypeDescriptor<ClientUIInfo> descriptor)
        {
            base.Configure(descriptor);
            descriptor.Field(a => a.Id)
                .Type<IdType>();
            descriptor.Field(a => a.Theme)
                .Type<StringType>();
            descriptor.Field(a => a.PublicKey)
                .Type<UuidType>();
        }
    }
}
