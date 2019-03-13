using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.ViewModels;

namespace Ards.Tools.Adif.Api.Controllers
{
    /// <summary>
    /// IARU Members. This table is not part of the ADIF Spec.
    /// </summary>
    [Route("api/IaruRegionMember")]
    [ApiController]
    public class IaruRegionMemberController : ControllerBase
    {
        private readonly AdifDomain _context;

        public IaruRegionMemberController(AdifDomain context)
        {
            _context = context;
        }

        /// <summary>
        /// Get All IARU Members
        /// </summary>
        /// <returns>Returns All IARU Members</returns>
        [Produces("application/json")]
        [HttpGet]
        public async Task<ActionResult<IEnumerable<IaruRegionMember>>> GetIaruRegionMember()
        {
            return await _context.IaruRegionMember.ToListAsync();
        }

        /// <summary>
        /// Get IARU Member by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns IARU Member by ID</returns>
        [Produces("application/json")]
        [HttpGet("{id}")]
        public async Task<ActionResult<IaruRegionMember>> GetIaruRegionMember(int id)
        {
            var iaruRegionMember = await _context.IaruRegionMember.FindAsync(id);

            if (iaruRegionMember == null)
            {
                return NotFound();
            }

            return iaruRegionMember;
        }

        /// <summary>
        /// Check if IARU Member exists by ID
        /// </summary>
        /// <param name="id"></param>
        /// <returns>Returns True if IARU Member exists by ID</returns>
        private bool IaruRegionMemberExists(int id)
        {
            return _context.IaruRegionMember.Any(e => e.IaruRegionMemberId == id);
        }
    }
}
