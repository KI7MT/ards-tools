using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.Tools.Domain.Adif.Adif.Models;

namespace Ards.Tools.Adif.Api.Controllers
{
    [Route("api/IaruRegionMember")]
    [ApiController]
    public class IaruRegionMemberController : ControllerBase
    {
        private readonly AdifDomainContext _context;

        public IaruRegionMemberController(AdifDomainContext context)
        {
            _context = context;
        }

        // GET: api/IaruRegionMember
        [HttpGet]
        public async Task<ActionResult<IEnumerable<IaruRegionMember>>> GetIaruRegionMember()
        {
            return await _context.IaruRegionMember.ToListAsync();
        }

        // GET: api/IaruRegionMember/5
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

        // PUT: api/IaruRegionMember/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutIaruRegionMember(int id, IaruRegionMember iaruRegionMember)
        {
            if (id != iaruRegionMember.Id)
            {
                return BadRequest();
            }

            _context.Entry(iaruRegionMember).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!IaruRegionMemberExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/IaruRegionMember
        [HttpPost]
        public async Task<ActionResult<IaruRegionMember>> PostIaruRegionMember(IaruRegionMember iaruRegionMember)
        {
            _context.IaruRegionMember.Add(iaruRegionMember);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (IaruRegionMemberExists(iaruRegionMember.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtAction("GetIaruRegionMember", new { id = iaruRegionMember.Id }, iaruRegionMember);
        }

        // DELETE: api/IaruRegionMember/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<IaruRegionMember>> DeleteIaruRegionMember(int id)
        {
            var iaruRegionMember = await _context.IaruRegionMember.FindAsync(id);
            if (iaruRegionMember == null)
            {
                return NotFound();
            }

            _context.IaruRegionMember.Remove(iaruRegionMember);
            await _context.SaveChangesAsync();

            return iaruRegionMember;
        }

        private bool IaruRegionMemberExists(int id)
        {
            return _context.IaruRegionMember.Any(e => e.Id == id);
        }
    }
}
