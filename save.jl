using PyCall
using PyPlot

@pyimport matplotlib.animation as anim  # After using PyPlot, so matplotlib installed via conda.
const wave_propagation_filename = "wave_propagation.mp4"

function saveall(output_path=".")
    fig = figure()
    ims = []
    for i_time in 1:10
        im = PyPlot.imshow(rand(4, 8), cmap="viridis")
        if 1 == i_time
            PyPlot.colorbar()
        end
        PyPlot.title("Wave amplitude [dB]")
        PyPlot.xlabel("Depth [m]")
        PyPlot.ylabel("Azimuth [m]")
        push!(ims, PyCall.PyObject[im])
    end
    #= close() =#

    # If matplotlib complains, ensure that
    # a) ffmpeg is installed with libx264 support, and
    # b) matplotlib is built with ffmpeg support enabled
    ani = anim.ArtistAnimation(fig, ims, interval=30, blit=true, repeat=false)
    anim_filename = wave_propagation_filename
    mywriter = anim.FFMpegWriter()
    ani[:save](joinpath(output_path, anim_filename), mywriter)
end

saveall()
