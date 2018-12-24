package org.rajawali3d.examples.examples.materials.materials;

import android.opengl.GLES20;
import org.rajawali3d.examples.R;
import org.rajawali3d.materials.shaders.FragmentShader;
import org.rajawali3d.util.RawShaderLoader;

public class CustomRawFragmentShader extends FragmentShader {
	private int muTextureInfluenceHandle;
	private int mTexelWidthHandle, mTexelHeightHandle;
	private float mTexelWidth, mTexelHeight;

	public CustomRawFragmentShader()
	{
		super();
		mNeedsBuild = false;
		initialize();
	}

	@Override
	public void initialize()
	{
		mShaderString = RawShaderLoader.fetch(R.raw.custom_frag_shader);
	}

	@Override
	public void main() {

	}

	@Override
	public void setLocations(final int programHandle)
	{
		super.setLocations(programHandle);
		muTextureInfluenceHandle = getUniformLocation(programHandle, "uInfluencemyTex");
		mTexelWidthHandle = getUniformLocation(programHandle, "texelWidth");
		mTexelHeightHandle = getUniformLocation(programHandle, "texelHeight");
	}

	@Override
	public void applyParams()
	{
		super.applyParams();
		GLES20.glUniform1f(muTextureInfluenceHandle, .9f);
		GLES20.glUniform1f(mTexelWidthHandle, mTexelWidth);
		GLES20.glUniform1f(mTexelHeightHandle, mTexelHeight);
	}

	public void setTexelSize(float texelWidth, float texelHeight) {
		mTexelWidth = texelWidth;
		mTexelHeight = texelHeight;
	}
}
