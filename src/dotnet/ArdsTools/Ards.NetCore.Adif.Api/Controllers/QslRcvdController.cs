using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Ards.NetCore.Adif.Domain.Models;

namespace Ards.NetCore.Adif.Api.Controllers
{
    [Route("api/QslRcvd")]
    [ApiController]
    public class QslRcvdController : ControllerBase
    {
        private readonly AdifContext _context;

        public QslRcvdController(AdifContext context)
        {
            _context = context;
        }

        // GET: api/QslRcvd
        [HttpGet]
        public async Task<ActionResult<IEnumerable<QslRcvd>>> GetQslRcvd()
        {
            return await _context.QslRcvd.ToListAsync();
        }

        // GET: api/QslRcvd/5
        [HttpGet("{id}")]
        public async Task<ActionResult<QslRcvd>> GetQslRcvd(int id)
        {
            var qslRcvd = await _context.QslRcvd.FindAsync(id);

            if (qslRcvd == null)
            {
                return NotFound();
            }

            return qslRcvd;
        }

        // PUT: api/QslRcvd/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutQslRcvd(int id, QslRcvd qslRcvd)
        {
            if (id != qslRcvd.Id)
            {
                return BadRequest();
            }

            _context.Entry(qslRcvd).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!QslRcvdExists(id))
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

        // POST: api/QslRcvd
        [HttpPost]
        public async Task<ActionResult<QslRcvd>> PostQslRcvd(QslRcvd qslRcvd)
        {
            _context.QslRcvd.Add(qslRcvd);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetQslRcvd", new { id = qslRcvd.Id }, qslRcvd);
        }

        // DELETE: api/QslRcvd/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<QslRcvd>> DeleteQslRcvd(int id)
        {
            var qslRcvd = await _context.QslRcvd.FindAsync(id);
            if (qslRcvd == null)
            {
                return NotFound();
            }

            _context.QslRcvd.Remove(qslRcvd);
            await _context.SaveChangesAsync();

            return qslRcvd;
        }

        private bool QslRcvdExists(int id)
        {
            return _context.QslRcvd.Any(e => e.Id == id);
        }
    }
}
